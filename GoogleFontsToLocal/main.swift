import Foundation

struct Font {
    var url: String
    var source: String
    var style: String
    var family: String
    var weight: String
}

let arguments = CommandLine.arguments

let command = arguments[0]

// Check that we have the correct number of arguments or --help
guard arguments.count == 2 else {
    printHelp()
    exit(1)
}

let cssPath = arguments[1]

if cssPath == "--help" || cssPath == "-h" {
    printHelp()
    exit(0)
}

// Read the contents of the file into a string
guard let fileContents = try? String(contentsOfFile: cssPath) else {
    fatalError("Failed to read file")
}

// Find all the blocks that match the criteria
let pattern = #"\/\* latin \*\/([\s\S]*?)\}"#
let regex = try! NSRegularExpression(pattern: pattern)
let range = NSRange(location: 0, length: fileContents.utf16.count)
let matches = regex.matches(in: fileContents, range: range)

var cssTextArray = [String]()

// Extract and print the text for each match
for match in matches {
    let start = match.range(at: 1).location
    let length = match.range(at: 1).length
    let matchRange = NSRange(location: start, length: length + 1)
    let matchText = (fileContents as NSString).substring(with: matchRange)
    cssTextArray.append(matchText)
}

var fontList = [Font]()

var output = ""

for cssText in cssTextArray {

    var thisFont = Font(url: "", source: "", style: "", family: "", weight: "")

    let lines = cssText.components(separatedBy: .newlines)
    for line in lines {
        if line.contains("url(") {
            let url = line.components(separatedBy: "url(")[1].components(separatedBy: ")")[0]

            thisFont.source = url
        }

        if line.contains("font-style:") {
            let style = line.components(separatedBy: "font-style:")[1].components(separatedBy: ";")[0].trimmingCharacters(in: .whitespacesAndNewlines)

            thisFont.style = style
        }

        if line.contains("font-weight:") {
            let weight = line.components(separatedBy: "font-weight:")[1].components(separatedBy: ";")[0].trimmingCharacters(in: .whitespacesAndNewlines)

            thisFont.weight = weight
        }

        if line.contains("font-family:") {
            let family = line.components(separatedBy: "font-family:")[1].components(separatedBy: ";")[0].replacingOccurrences(of: "'", with: "").trimmingCharacters(in: .whitespacesAndNewlines)

            thisFont.family = family
        }
    }

    // get extension from url
    let ext = thisFont.source.components(separatedBy: ".").last!

    let fontInfo = familyFile(font: thisFont)

    let url = "\(fontInfo).\(ext)"

    thisFont.url = url

    output += "/* \(fontInfo) */\n" + cssText.replacingOccurrences(of: thisFont.source, with: url) + "\n\n"

    fontList.append(thisFont)
}

// Show CSS text
print(output)

print("/* Curl command to download fonts")

for font in fontList {
    print("curl \(font.source) -o \(font.url)")
}

print("*/")

func familyFile(font: Font) -> String {
    let familyNameWithoutSpaces = font.family.replacingOccurrences(of: " ", with: "-")
    return "\(familyNameWithoutSpaces)-\(font.weight)-\(font.style)"
}

func printHelp() {
    print("Usage: \(command) <css file>")
}

