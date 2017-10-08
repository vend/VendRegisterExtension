# VendRegisterExtension

[![CI Status](http://img.shields.io/travis/Vend/VendRegisterExtension.svg?style=flat)](https://travis-ci.org/Vend/VendRegisterExtension)
[![Version](https://img.shields.io/cocoapods/v/VendRegisterExtension.svg?style=flat)](http://cocoapods.org/pods/VendRegisterExtension)
[![License](https://img.shields.io/cocoapods/l/VendRegisterExtension.svg?style=flat)](http://cocoapods.org/pods/VendRegisterExtension)
[![Platform](https://img.shields.io/cocoapods/p/VendRegisterExtension.svg?style=flat)](http://cocoapods.org/pods/VendRegisterExtension)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Inputs

Data is provided to the extension in a JSON format. Here is an example payload:

```json
{
  "payload": {
    "sale": {
      "identifier": "654321-1234-4321-1234-654321",
      "lineItems": [{
        "unitTax": "45",
        "name": "Shoes",
        "quantity": "1",
        "taxIdentifier": "AAAAAAA-BBBB-DDDD-CCCC-AAAAAAA",
        "unitPrice": "300",
        "identifier": "123456-AAAA-BBBB-CCCC-DDDDDDD"
      }],
      "customer": {
        "identifier": "123456-ABCD-ABCD-ABCD-00000000"
      },
      "totals": {
        "toPay": "345",
        "paid": "0",
        "price": "345",
        "tax": "45"
      }
    },
    "retailer": {
      "domainPrefix": "aTestStore",
      "identifier": "123456-1234-1234-1234-123456"
    }
  },
  "version": 1
}
```

### Outputs
The simplest way to send data back to VendRegister is to use the `VendRegisterExtensionOperation` enum which
provides a helper to create a valid `NSExtensionItem`.

Otherwise, you must create a valid `NSExtensionItem` that contains a dictionary with the following format:
```json
{
  "operation" : "addLineItems",
  "version" : 1,
  "parameters" : [
    {
      "unitTax": "45",
      "name": "Shoes",
      "quantity": "1",
      "taxIdentifier": "AAAAAAA-BBBB-DDDD-CCCC-AAAAAAA",
      "unitPrice": "300",
      "identifier": "123456-AAAA-BBBB-CCCC-DDDDDDD"
    }
  ]
}
```
Please note that the NSExtensionItem is not expecting a JSON object but instead an `NSDictionary` representation of that object and that the decimal numbers are represented as strings.


## Requirements

## Installation

VendRegisterExtension is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "VendRegisterExtension"
```

## Author

TomCarey

## License

VendRegisterExtension is available under the MIT license. See the LICENSE file for more info.
