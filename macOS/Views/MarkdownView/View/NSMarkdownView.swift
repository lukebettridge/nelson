//
//  NSMarkdownView.swift
//  Nelson (macOS)
//
//  Created by Luke Bettridge on 21/02/2021.
//

import AppKit

class NSMarkdownView: NSView {
    weak var layoutManagerDelegate: NSLayoutManagerDelegate?
    weak var textViewDelegate: NSTextViewDelegate?
    
    var isEditable: Bool {
        didSet {
            if textView.isEditable != isEditable {
                textView.isEditable = isEditable
                textView.replaceLayoutManager()
            }
        }
    }
    
    var text: String {
        didSet {
            if textView.string != text {
                textView.string = text
                (textView.textStorage as? MarkdownViewTextStorage)?
                    .applyStylesToRange(NSMakeRange(0, text.count))
            }
        }
    }
    
    private lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.autoresizingMask = [.width, .height]
        scrollView.hasVerticalScroller = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var textView: NSMarkdownTextView = {
        let textContainer = MarkdownViewTextContainer(containerSize: scrollView.frame.size)
        textContainer.containerSize = NSSize(
            width: scrollView.contentSize.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        textContainer.widthTracksTextView = true
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        layoutManager.delegate = layoutManagerDelegate
        
        let textStorage = MarkdownViewTextStorage()
        textStorage.addLayoutManager(layoutManager)
        
        let textView = NSMarkdownTextView(frame: .zero, textContainer: textContainer)
        textView.allowsUndo = true
        textView.autoresizingMask = [.width]
        textView.backgroundColor = .clear
        textView.delegate = textViewDelegate
        textView.isAutomaticLinkDetectionEnabled = true
        textView.isEditable = true
        textView.isHorizontallyResizable = false
        textView.isVerticallyResizable = true
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.minSize = NSSize(width: 0, height: scrollView.contentSize.height)
        textView.textContainerInset.height = 40
        return textView
    }()
    
    init(
        _ text: String,
        isEditable: Bool = true
    ) {
        self.text = text
        self.isEditable = isEditable
        super.init(frame: .zero)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        super.viewWillDraw()
        
        setupScrollView()
        setupTextView()
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    
    func setupTextView() {
        scrollView.documentView = textView
        textView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        textView.applyMarkdownStyles()
    }
}
