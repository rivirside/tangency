import Foundation
import CoreGraphics
import CoreText

let pageWidth: CGFloat = 612
let pageHeight: CGFloat = 792

func createContext(url: URL) -> CGContext {
    var mediaBox = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    guard let ctx = CGContext(url as CFURL, mediaBox: &mediaBox, nil) else {
        fatalError("Unable to create PDF context")
    }
    ctx.beginPDFPage(nil)
    return ctx
}

func finishContext(_ ctx: CGContext) {
    ctx.endPDFPage()
    ctx.closePDF()
}

func drawText(_ ctx: CGContext, text: String, rect: CGRect, fontSize: CGFloat = 12, bold: Bool = false) {
    let fontName = bold ? "Helvetica-Bold" : "Helvetica"
    guard let font = CTFontCreateWithName(fontName as CFString, fontSize, nil) else { return }
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineBreakMode = .byWordWrapping
    paragraph.alignment = .left
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .paragraphStyle: paragraph
    ]
    let attributed = NSAttributedString(string: text, attributes: attributes)
    let framesetter = CTFramesetterCreateWithAttributedString(attributed)
    let path = CGMutablePath()
    path.addRect(rect)
    let frame = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: attributed.length), path, nil)
    CTFrameDraw(frame, ctx)
}

func drawBlankTemplate(to url: URL) {
    let ctx = createContext(url: url)
    ctx.setFillColor(CGColor.white)
    ctx.fill(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
    drawText(ctx, text: "Power Map Canvas", rect: CGRect(x: 40, y: 720, width: 400, height: 40), fontSize: 24, bold: true)
    drawText(ctx, text: "Use this canvas to map who is impacted vs who has influence.", rect: CGRect(x: 40, y: 690, width: 500, height: 30), fontSize: 12)
    let instructions = [
        "1. Write the demand and win statement at the top.",
        "2. Place the PRIMARY TARGET in the center circle.",
        "3. Add secondary targets in the middle ring.",
        "4. Add allies/opponents/undecided in the outer ring (color code).",
        "5. Draw arrows for relationships and record follow-ups below."
    ]
    var y: CGFloat = 660
    for line in instructions {
        drawText(ctx, text: line, rect: CGRect(x: 40, y: y, width: 520, height: 25), fontSize: 11)
        y -= 20
    }
    ctx.setLineWidth(1)
    ctx.stroke(CGRect(x: 40, y: 600, width: 520, height: 35))
    drawText(ctx, text: "Demand:", rect: CGRect(x: 45, y: 610, width: 200, height: 20), fontSize: 11, bold: true)
    ctx.stroke(CGRect(x: 40, y: 550, width: 520, height: 35))
    drawText(ctx, text: "Win Statement:", rect: CGRect(x: 45, y: 560, width: 200, height: 20), fontSize: 11, bold: true)

    let center = CGPoint(x: pageWidth/2, y: 340)
    ctx.setLineWidth(1.5)
    for radius in [180, 140, 90] {
        ctx.strokeEllipse(in: CGRect(x: center.x - CGFloat(radius), y: center.y - CGFloat(radius), width: CGFloat(radius*2), height: CGFloat(radius*2)))
    }
    drawText(ctx, text: "PRIMARY\nTARGET", rect: CGRect(x: center.x - 40, y: center.y - 25, width: 80, height: 60), fontSize: 12, bold: true)
    drawText(ctx, text: "Secondary", rect: CGRect(x: center.x - 40, y: center.y + 140, width: 80, height: 20), fontSize: 11)
    drawText(ctx, text: "Secondary", rect: CGRect(x: center.x - 40, y: center.y - 170, width: 80, height: 20), fontSize: 11)
    drawText(ctx, text: "Allies / Opponents / Moveable", rect: CGRect(x: center.x - 130, y: center.y + 185, width: 260, height: 20), fontSize: 11)

    drawText(ctx, text: "Legend", rect: CGRect(x: 60, y: 250, width: 100, height: 20), fontSize: 13, bold: true)
    let legendItems = [("Ally", CGColor(genericCMYKCyan: 0.6, magenta: 0, yellow: 0.7, black: 0, alpha: 1)),
                       ("Moveable", CGColor(genericCMYKCyan: 0, magenta: 0.15, yellow: 0.9, black: 0, alpha: 1)),
                       ("Opponent", CGColor(genericCMYKCyan: 0, magenta: 0.8, yellow: 0.8, black: 0, alpha: 1))]
    var legendY: CGFloat = 225
    for (label, color) in legendItems {
        ctx.setFillColor(color)
        ctx.fill(CGRect(x: 60, y: legendY, width: 20, height: 15))
        drawText(ctx, text: label, rect: CGRect(x: 90, y: legendY, width: 100, height: 20), fontSize: 11)
        legendY -= 25
    }

    drawText(ctx, text: "Follow-up Tracker", rect: CGRect(x: 40, y: 170, width: 300, height: 20), fontSize: 14, bold: true)
    let columns = ["Influence Node", "Category", "Owner", "Next Action", "Due Date"]
    let widths: [CGFloat] = [150, 100, 90, 150, 80]
    var x: CGFloat = 40
    let headerY: CGFloat = 140
    for (idx, title) in columns.enumerated() {
        let w = widths[idx]
        ctx.stroke(CGRect(x: x, y: headerY, width: w, height: 25))
        drawText(ctx, text: title, rect: CGRect(x: x+5, y: headerY+5, width: w-10, height: 15), fontSize: 10, bold: true)
        ctx.stroke(CGRect(x: x, y: 110, width: w, height: 25))
        ctx.stroke(CGRect(x: x, y: 80, width: w, height: 25))
        ctx.stroke(CGRect(x: x, y: 50, width: w, height: 25))
        x += w
    }

    finishContext(ctx)
}

func drawExampleTemplate(to url: URL) {
    let ctx = createContext(url: url)
    ctx.setFillColor(CGColor.white)
    ctx.fill(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
    drawText(ctx, text: "Stakeholder Map Example: Clean Air Now", rect: CGRect(x: 40, y: 720, width: 500, height: 30), fontSize: 20, bold: true)
    drawText(ctx, text: "Students want a clean-trucking ordinance near Riverdale schools. The map shows impact vs influence.", rect: CGRect(x: 40, y: 690, width: 520, height: 40), fontSize: 11)
    let center = CGPoint(x: pageWidth/2, y: 360)
    ctx.setLineWidth(1.5)
    for radius in [180, 140, 90] {
        ctx.strokeEllipse(in: CGRect(x: center.x - CGFloat(radius), y: center.y - CGFloat(radius), width: CGFloat(radius*2), height: CGFloat(radius*2)))
    }
    drawText(ctx, text: "Diesel Truck Ordinance", rect: CGRect(x: center.x - 70, y: center.y - 20, width: 140, height: 40), fontSize: 11, bold: true)
    struct Stakeholder { let name: String; let color: CGColor; let point: CGPoint }
    let green = CGColor(genericCMYKCyan: 0.6, magenta: 0, yellow: 0.7, black: 0, alpha: 1)
    let amber = CGColor(genericCMYKCyan: 0, magenta: 0.15, yellow: 0.9, black: 0, alpha: 1)
    let red = CGColor(genericCMYKCyan: 0, magenta: 0.8, yellow: 0.8, black: 0, alpha: 1)
    let nodes = [
        Stakeholder(name: "Parents", color: green, point: CGPoint(x: center.x - 110, y: center.y + 120)),
        Stakeholder(name: "Youth Climate", color: green, point: CGPoint(x: center.x + 100, y: center.y + 130)),
        Stakeholder(name: "School Nurses", color: green, point: CGPoint(x: center.x - 10, y: center.y + 40)),
        Stakeholder(name: "Council President", color: amber, point: CGPoint(x: center.x + 120, y: center.y - 170)),
        Stakeholder(name: "Logistics Assoc.", color: red, point: CGPoint(x: center.x - 150, y: center.y - 130)),
        Stakeholder(name: "Port Authority", color: amber, point: CGPoint(x: center.x + 170, y: center.y - 10)),
        Stakeholder(name: "Business Alliance", color: amber, point: CGPoint(x: center.x - 180, y: center.y + 20))
    ]
    for node in nodes {
        ctx.setFillColor(node.color)
        ctx.fillEllipse(in: CGRect(x: node.point.x-8, y: node.point.y-8, width: 16, height: 16))
        drawText(ctx, text: node.name, rect: CGRect(x: node.point.x + 10, y: node.point.y - 5, width: 150, height: 20), fontSize: 10)
    }
    drawText(ctx, text: "Legend", rect: CGRect(x: 60, y: 230, width: 200, height: 20), fontSize: 12, bold: true)
    let legendNodes = [("High impact + co-leads", green), ("Persuadable power", amber), ("Opposition", red)]
    var legendY: CGFloat = 210
    for (label,color) in legendNodes {
        ctx.setFillColor(color)
        ctx.fillEllipse(in: CGRect(x: 60, y: legendY, width: 12, height: 12))
        drawText(ctx, text: label, rect: CGRect(x: 80, y: legendY - 2, width: 220, height: 16), fontSize: 10)
        legendY -= 20
    }
    drawText(ctx, text: "Insights", rect: CGRect(x: 40, y: 160, width: 200, height: 20), fontSize: 13, bold: true)
    let insights = [
        "Parents + youth (Q1/Q2) led storytelling and media.",
        "School nurses validated health data in council briefings.",
        "Council + business targets received economic one-pagers.",
        "Logistics lobby mapped for pressure while negotiating timeline."
    ]
    var insightsY: CGFloat = 140
    for line in insights {
        drawText(ctx, text: "• " + line, rect: CGRect(x: 40, y: insightsY, width: 520, height: 20), fontSize: 11)
        insightsY -= 22
    }
    finishContext(ctx)
}

let outputDir = URL(fileURLWithPath: "resources/assets/action-kit/power-mapping-lab")
try? FileManager.default.createDirectory(at: outputDir, withIntermediateDirectories: true)

let blankURL = outputDir.appendingPathComponent("power-map-canvas.pdf")
let exampleURL = outputDir.appendingPathComponent("power-map-example.pdf")
drawBlankTemplate(to: blankURL)
drawExampleTemplate(to: exampleURL)
