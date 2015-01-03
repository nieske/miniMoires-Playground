import CoreData

class Person {
    var name: String
    var birthyear: Int
    init(name: String, birthyear: Int) {
        self.name = name
        self.birthyear = birthyear
    }
    func changeName(name: String) -> Void {
        self.name = name
    }
}

class Memoires {
    var person: Person
    var entries: [Int: Entry] = [:]
    init(person: Person) {
        self.person = person
    }
    
    func addEntry(entry: Entry) -> Void {
        if entry.year >= person.birthyear {
            entries[entry.year] = entry
        }
        // else if entry already exists {
        // tell user: this entry already exists. Do you want to edit?
        // }
        else {
            println("Are you sure? This is before you were born.")
            // how to display this on the screen?
            // also maybe option to override (e.g. year my parents met)
        }
    }
    
    func getEntry(year: Int) -> Entry? {
        return entries[year]
    }
    
    func save() -> Void {
        let documentDirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        
        if documentDirs != nil {
            let fileName = person.name + ".txt"
            let dir = documentDirs[0] as String
            let saveFile = dir.stringByAppendingPathComponent(fileName)
            let text = makeText(entries)
            
            // writing
            text.writeToFile(saveFile, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
            
            // reading
            let text2 = String(contentsOfFile: saveFile, encoding: NSUTF8StringEncoding, error: nil)
        }
    }
    
    func saveEntry(year: Int) -> Void {
        let documentDirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)

        if documentDirs != nil {
            let fileName = "\(person.name).\(year).txt"
            let dir = documentDirs[0] as String
            let saveFile = dir.stringByAppendingPathComponent(fileName)
            let text = entries[year]?.text
            
            // writing
            if text != nil {
                    text!.writeToFile(saveFile, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
            }
            
            // reading
            let text2 = String(contentsOfFile: saveFile, encoding: NSUTF8StringEncoding, error: nil)
        }
    }
}

func makeText(dictionary: [Int: Entry]) -> String {
    var text = ""
    for (year, entry) in dictionary {
        text += "\(year)\n\(entry.text)\n\n"
    }
    return text
}

class Entry {
    var text: String
    var year: Int
    var createdDate: Int = 0
    var lastEditedDate: Int = 0
    init(year: Int, text: String) {
        self.year = year
        self.text = text
    }
}

var nieske = Person(name: "Nieske", birthyear: 1983)
var nieskesMemoires = Memoires(person: nieske)
nieskesMemoires.addEntry(Entry(year: 2014, text: "Het was een leuk jaar"))
nieskesMemoires.addEntry(Entry(year: 2001, text: "Een nieuwe eeuw!"))
nieskesMemoires.addEntry(Entry(year: 1983, text: "Ik werd geboren. Ik weet het nog goed."))

nieskesMemoires.entries
nieskesMemoires.getEntry(1983)
nieskesMemoires.getEntry(2014)
nieskesMemoires.getEntry(1032)

makeText(nieskesMemoires.entries)

nieskesMemoires.save()
nieskesMemoires.saveEntry(2014)
nieskesMemoires.saveEntry(1901)
nieskesMemoires.saveEntry(1983)









