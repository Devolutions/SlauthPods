// https://github.com/Quick/Quick

import Quick
import Nimble
import Slauth

class TableOfContentsSpec: QuickSpec {
    override func spec() {
		describe("U2f tests") {
			let att_cert = [UInt8](Data(base64Encoded: "MIICODCCAd6gAwIBAgIJAKsa9WC9HvEuMAoGCCqGSM49BAMCMFoxDzANBgNVBAMMBlNsYXV0aDELMAkGA1UEBhMCQ0ExDzANBgNVBAgMBlF1ZWJlYzETMBEGA1UEBwwKTGF2YWx0cm91ZTEUMBIGA1UECgwLRGV2b2x1dGlvbnMwHhcNMTkwNzAyMTgwMTUyWhcNMzEwNjI5MTgwMTUyWjBaMQ8wDQYDVQQDDAZTbGF1dGgxCzAJBgNVBAYTAkNBMQ8wDQYDVQQIDAZRdWViZWMxEzARBgNVBAcMCkxhdmFsdHJvdWUxFDASBgNVBAoMC0Rldm9sdXRpb25zMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE15PAnpUUIzbgKxD6RFuNMjjl/cD06vKRBtl0X/CiNzc3igTh1qcc00QICgAQUxdvHSn+DaSRki/kI9OJ8lkPGqOBjDCBiTAdBgNVHQ4EFgQU7iZ4JceUHOuWoMymFGm+ZBUmwwgwHwYDVR0jBBgwFoAU7iZ4JceUHOuWoMymFGm+ZBUmwwgwDgYDVR0PAQH/BAQDAgWgMCAGA1UdJQEB/wQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAVBgNVHREEDjAMggpzbGF1dGgub3JnMAoGCCqGSM49BAMCA0gAMEUCIEdjPFNsund4FXs/1HpK4AXWQ0asfY6ERhNlg29VGS6pAiEAx8f2lrlVV1tASWbC/edTgH9JsCbANuXW/9FZcWHGl2E=")!)
			
			let att_key = [UInt8](Data(base64Encoded: "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQgzgUSoDttmryF0C+ck4GppKwssha7ngah0dfezfTBzDOhRANCAATXk8CelRQjNuArEPpEW40yOOX9wPTq8pEG2XRf8KI3NzeKBOHWpxzTRAgKABBTF28dKf4NpJGSL+Qj04nyWQ8a")!)
			
			let json = "{\"appId\":\"https://login.devolutions.com/\",\"registerRequests\":[{\"challenge\":\"UzAxNE0yMTBWM1JDYzA1a1JqWndRUT09\",\"version\":\"U2F_V2\"}],\"registeredKeys\":[],\"requestId\":1,\"timeoutSeconds\":300,\"type\":\"u2f_register_request\"}"
			
			
			if let web_r = WebRequest.init(json: json) {
				let origin = web_r.getOrigin()
				
				it("Origin is goude") {
					expect(origin!) == "https://login.devolutions.com/"
				}
				
				let rsp = web_r.register(origin: origin!, attestationCert: att_cert, attestationKey: att_key)
				
				let key = rsp.getSigningKey();
				print("\(key!.getKeyHandle())")
				print("\(key!.toString())")
				print("\(rsp.toJson())")
			}
		}
    }
}
