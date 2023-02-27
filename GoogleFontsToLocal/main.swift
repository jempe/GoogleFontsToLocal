import Foundation

struct Font {
    var url: String
    var source: String
    var style: String
    var family: String
    var weight: String
}

let arguments = CommandLine.arguments

let cssPath = arguments[1]


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

    let fontInfo = "\(thisFont.family)-\(thisFont.weight)-\(thisFont.style)"

    let url = "\(fontInfo).\(ext)"

    thisFont.url = url

    output += "/* \(fontInfo) */\n" + cssText.replacingOccurrences(of: thisFont.source, with: url) + "\n\n"

    fontList.append(thisFont)
}

// Show CSS text
print(output)

print("/* Curl command to download fonts")

for font in fontList {
    // get extension from url
    let ext = font.url.components(separatedBy: ".").last!

    print("curl \(font.url) -o \(font.family)-\(font.weight)-\(font.style).\(ext)")
}

print("*/")

