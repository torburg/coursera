// Этот файл пуст не по ошибке. В этот раз вам необходимо самостоятельно импортировать необходимые модули и запустить проверку

import FirstCourseThirdTaskChecker

//Checker.checkExtensions(Checker)
//Checker.checkProtocols()

class StackSubClass: ArrayInitializableStorage {
    
    private var array: [Int]
    
    override var count: Int {
        return array.count
    }

    /// Инициализатор для создания пустого хранилища.
    required public init() {
        self.array = []
        super.init()
    }
    
    required init(array: [Int]) {
        self.array = array
        super.init()
    }
    
    /// Метод для добавления новых элементов в хранилище.
    ///
    /// - Parameter element: Новый элемент
    override func push(_ element: Int) {
        array.append(element)
    }

    /// Метод для получения элементов. Checker не будет пытаться достать элемент из пустого
    /// хранилища. Поэтому не нужно реализовывать такую проверку. Полученный элемент из хранилища
    /// должен быть удален.
    ///
    /// - Returns: Элемент, полученный из хранилища.
    override func pop() -> Int {
        return array.popLast()!
    }
}

class QueueSubclass: ArrayInitializableStorage {
    private var array: [Int]
    
    override var count: Int {
        return array.count
    }

    /// Инициализатор для создания пустого хранилища.
    required public init() {
        self.array = []
        super.init()
    }
    
    required init(array: [Int]) {
        self.array = array
        super.init()
    }
    
    /// Метод для добавления новых элементов в хранилище.
    ///
    /// - Parameter element: Новый элемент
    override func push(_ element: Int) {
        array.append(element)
    }

    /// Метод для получения элементов. Checker не будет пытаться достать элемент из пустого
    /// хранилища. Поэтому не нужно реализовывать такую проверку. Полученный элемент из хранилища
    /// должен быть удален.
    ///
    /// - Returns: Элемент, полученный из хранилища.
    override func pop() -> Int {
        defer { self.array = Array(array.dropFirst()) }
        return array.first!
    }
}

struct StackStruct: ArrayInitializable, StorageProtocol {
    init() {
        array = []
    }
    
    
    private var array: [Int]
    
    init(array: [Int]) {
        self.array = array
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int {
        return array.removeLast()
    }
    
    
}

struct QueueStruct: ArrayInitializable, StorageProtocol {
    
    init() {
        array = []
    }
    
    
    private var array: [Int]

    init(array: [Int]) {
        self.array = array

    }
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int {
        defer { self.array = Array(array.dropFirst()) }
        return array.first!
    }
}

extension User: JSONSerializable {
    public func toJSON() -> String {
        return "{\"fullName\": \"\(self.fullName)\", \"email\": \"\(self.email)\"}"
    }
}

extension User: JSONInitializable {
    public convenience init(JSON: String) {
        let JSONFields = JSON.replacingOccurrences(of: "{", with: "")
            .replacingOccurrences(of: "}", with: "")
            .split(separator: ",")
        let fullName = String(JSONFields[0].split(separator: ":")[1])
        let email = String(JSONFields[1].split(separator: ":")[1])
        self.init()
        self.fullName = fullName.replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "\\", with: "")
            .trimmingCharacters(in: .whitespaces)
        self.email = email.replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "\\", with: "")
            .trimmingCharacters(in: .whitespaces)
    }
}

let checker = Checker()
let user: User & JSONSerializable & JSONInitializable = User()
user.email = "huy"
user.fullName = "pizda"

let json = user.toJSON()

checker.checkInheritance(stack: StackSubClass(), queue: QueueSubclass())
checker.checkProtocols(stack: StackStruct(), queue: QueueStruct())
checker.checkExtensions(userType: type(of: user))
