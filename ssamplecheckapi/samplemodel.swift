//
//  samplemodel.swift
//  ssamplecheckapi
//
//  Created by Bareeth on 30/04/24.
//

import Foundation
// MARK: - Welcome


// MARK: - Recipe
class Recipe: Codable {
    let id: Int
    let name: String


    enum CodingKeys: String, CodingKey {
        case id, name
    }

    required init(from decoder : Decoder) throws{
          let container = try decoder.container(keyedBy: CodingKeys.self)
        
    
        self.id = container.safeDecodeValue(forKey: .id)
        self.name = container.safeDecodeValue(forKey: .name)
      
      
    }
    init() {
      
        self.id = 0
        self.name = ""
      
       

    }
}

enum Difficulty: String, Codable {
    case easy = "Easy"
    case medium = "Medium"
}
//
//  SellProductCategoryModel.swift
//  popTok
//
//  Created by trioangle on 29/02/24.
//

import Foundation

class SellProductCategoryModel: Codable {
  
 
    let recipes: [Recipe]
    let total, skip, limit: Int
    enum CodingKeys: String, CodingKey {
        case recipes
        case total
      
       case skip = "skip"
     
        case limit = "limit"
     
    }
    required init(from decoder : Decoder) throws{
          let container = try decoder.container(keyedBy: CodingKeys.self)
        
    
        self.total = container.safeDecodeValue(forKey: .total)
        self.skip = container.safeDecodeValue(forKey: .skip)
        self.recipes = try container.decodeIfPresent([Recipe].self, forKey: .recipes) ?? [Recipe]()
        self.limit = container.safeDecodeValue(forKey: .limit)
      
    }
    init() {
      
        self.total = 0
        self.skip = 0
        self.limit = 0
      
        self.recipes = [Recipe]()
       

    }
}
class SellProductCategory: Codable {
    let _id , category_id: Int
    let image,url,description,category_name,name,product_name: String
    let images: [String]
 
  

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case image = "image"
        case url = "url"
        case category_id = "category_id"
        case description = "description"
  case category_name = "category_name"
        case product_name = "product_name"
        case name
        case images
    }


    required init(from decoder : Decoder) throws{
          let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self._id = container.safeDecodeValue(forKey: ._id)
        self.image = container.safeDecodeValue(forKey: .image)
        self.url = container.safeDecodeValue(forKey: .url)
        self.category_id = container.safeDecodeValue(forKey: .category_id)
        self.description = container.safeDecodeValue(forKey: .description)
        self.category_name = container.safeDecodeValue(forKey: .category_name)
        self.name = container.safeDecodeValue(forKey: .name)
        self.images = container.safeDecodeValue(forKey: .images)
        self.product_name = container.safeDecodeValue(forKey: .product_name)

    }
    
    init() {
        self._id = 0
        self.image = ""
        self.url = ""
        self.category_id = 0
        self.description = ""
        self.category_name = ""
        self.name = ""
        self.images = []
        self.product_name = ""
    }
}
public extension KeyedDecodingContainer{
    
    func safeDecodeValue<T : SafeDecodable & Decodable>(forKey key : Self.Key) -> T{
    
        if let value = try? self.decodeIfPresent(T.self, forKey: key){
            return value
        }else if let value = try? self.decodeIfPresent(String.self, forKey: key){
            return value.cast()
        }else if let value = try? self.decodeIfPresent(Int.self, forKey: key){
            return value.cast()
        }else if let value = try? self.decodeIfPresent(Float.self, forKey: key){
            return value.cast()
        }else if let value = try? self.decodeIfPresent(Double.self, forKey: key){
            return value.cast()
        }else if let value = try? self.decodeIfPresent(Bool.self, forKey: key){
            return value.cast()
        }
        print("com.triongle::::Codable key is missing \"\(key)\"")
        return T.init()
       
    }
   
}

//MARK:- protocol SafeDecodable
public protocol Initializable {
    init()
}

public protocol DefaultValue : Initializable {}
extension DefaultValue {
    static var `default` : Self{return Self.init()}
}

public protocol SafeDecodable : DefaultValue{}
extension SafeDecodable{
    func cast<T: SafeDecodable>() -> T{return T.init()}
}
//MARK:- Int
extension Int : SafeDecodable{
    public func cast<T>() -> T where T : SafeDecodable {
        let castValue : T?
        switch T.self {
        case let x where x is String.Type:
            castValue = self.description as? T
        case let x where x is Double.Type:
            castValue = Double(self) as? T
        case let x where x is Bool.Type:
            castValue = (self != 0) as? T
        case let x where x is Float.Type:
            castValue = Float(self) as? T
        default:
            castValue = self as? T
        }
        return castValue ?? T.default
    }
    
    
}
//MARK:- Double
extension Double : SafeDecodable{
    public func cast<T>() -> T where T : SafeDecodable {
        let castValue : T?
        switch T.self {
        case let x where x is String.Type:
            castValue = self.description as? T
        case let x where x is Int.Type:
            castValue = Int(self) as? T
        case let x where x is Bool.Type:
            castValue = (self != 0) as? T
        case let x where x is Float.Type:
            castValue = Float(self) as? T
        default:
            castValue = self as? T
        }
        return castValue ?? T.init()
    }
}
//MARK:- Float
extension Float : SafeDecodable{
    public func cast<T>() -> T where T : SafeDecodable {
        let castValue : T?
        switch T.self {
        case let x where x is String.Type:
            castValue = self.description as? T
        case let x where x is Int.Type:
            castValue = Int(self) as? T
        case let x where x is Bool.Type:
            castValue = (self != 0) as? T
        case let x where x is Float.Type:
            castValue = Float(self) as? T
        default:
            castValue = self as? T
        }
        return castValue ?? T.init()
    }
}
//MARK:- String
extension String : SafeDecodable{
    public func cast<T>() -> T where T : SafeDecodable {
        let castValue : T?
        switch T.self {
        case let x where x is Int.Type:
            castValue = Int(self.description) as? T
        case let x where x is Double.Type:
            castValue = Double(self) as? T
        case let x where x is Bool.Type:
            castValue = ["true","yes","1"]
                .contains(self.lowercased()) as? T
        case let x where x is Float.Type:
            castValue = Float(self) as? T
        default:
            castValue = self as? T
        }
        return castValue ?? T.init()
    }
}
//MARK:- Bool
extension Bool : SafeDecodable{
    public func cast<T>() -> T where T : SafeDecodable {
        let castValue : T?
        switch T.self {
        case let x where x is String.Type:
            castValue = self.description as? T
        case let x where x is Double.Type:
            castValue = (self ? 1 : 0) as? T
        case let x where x is Bool.Type:
            castValue = (self ? 1 : 0) as? T
        case let x where x is Float.Type:
            castValue = (self ? 1 : 0) as? T
        default:
            castValue = self as? T
        }
        return castValue ?? T.init()
    }
}
//MARK:- Array
extension Array : SafeDecodable{
    public static var `default` : Array<Element> {return Array<Element>()}
    public func cast<T>() -> T where T : SafeDecodable {
       return T.init()
    }
}
