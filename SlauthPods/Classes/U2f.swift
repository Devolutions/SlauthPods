//
//  U2f.swift
//  Slauth
//
//  Created by Richer Archambault on 2019-07-01.
//

import Foundation

public class WebRequest : RustObject {
	var raw: OpaquePointer
	
	required init(raw: OpaquePointer) {
		self.raw = raw
	}
	
	public convenience init(json: String) {
		self.init(raw: web_request_from_json(json))
	}
	
	func intoRaw() -> OpaquePointer {
		return self.raw
	}
	
	deinit {
		web_request_free(raw)
	}
	
	func isRegister() -> Bool {
		return web_request_is_register(raw)
	}
	
	func isSign() -> Bool {
		return web_request_is_sign(raw)
	}
	
	func getOrigin() -> Optional<String> {
		let cOrigin = web_request_origin(raw)
		if cOrigin == nil {
			return .none
		}
		
		let origin = String(cString: cOrigin!)
		free(cOrigin)
		return .some(origin)
	}
	
	func getTimeout() -> UInt64 {
		return web_request_timeout(raw)
	}
	
	func getKeyHandle(origin: String) -> Optional<String> {
		if self.isSign() {
			let cKeyHandle = web_request_key_handle(raw, origin)
			if cKeyHandle == nil {
					return .none
			}
			
			let keyHandle = String(cString: cKeyHandle!)
			free(cKeyHandle)
			return .some(keyHandle)
		} else {
			return .none
		}
	}
	
	func register(origin: String, attestationCert: [UInt8], attestationKey: [UInt8]) -> WebResponse {
		return WebResponse(raw: web_request_register(raw, origin, attestationCert, UInt64(attestationCert.count), attestationKey, UInt64(attestationKey.count)))
	}
	
	func sing(origin: String, signingKey: SigningKey, counter: UInt32, userPresence: Bool) -> WebResponse {
		return WebResponse(raw: web_request_sign(raw, signingKey.intoRaw(), origin, UInt(counter), userPresence))
	}
	
}

public class SigningKey: RustObject {
	var raw: OpaquePointer
	
	public required init(raw: OpaquePointer) {
		self.raw = raw
	}
	
	public convenience init(string: String) {
		self.init(raw: signing_key_from_string(string))
	}
	
	func intoRaw() -> OpaquePointer {
		return self.raw
	}
	
	deinit {
		signing_key_free(raw)
	}
	
	func toString() -> String {
		let csString = signing_key_to_string(raw)
		let sign = String(cString: csString!)
		free(csString)
		return sign
	}
}

public class WebResponse: RustObject {
	var raw: OpaquePointer
	
	public required init(raw: OpaquePointer) {
		self.raw = raw
	}
	
	func intoRaw() -> OpaquePointer {
		return self.raw
	}
	
	deinit {
		client_web_response_free(raw)
	}
	
	func getSigningKey() -> Optional<SigningKey> {
		let rawKey = client_web_response_signing_key(raw)
		if rawKey == nil {
			return .none
		}
		
		return .some(SigningKey(raw: rawKey!))
	}
	
	func toJson() -> String {
		let cJsonString = client_web_response_to_json(raw)
		let json = String(cString: cJsonString!)
		free(cJsonString)
		return json
	}
}
