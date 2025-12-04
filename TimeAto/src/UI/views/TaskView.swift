//
//  TaskView.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 03.12.2025.
//

import Cocoa

final class TaskView: NSView {
    var task: TaskItem?
    
    private var imageView: NSImageView
    private var titleLabel: NSTextField
    private var infoLabel: NSTextField
    private var progressBar: NSProgressIndicator
    
    override init(frame frameRect: NSRect) {
        let imageFrame = NSRect(x: 10, y: 10, width: 20, height: 20)
        imageView = NSImageView(frame: imageFrame)
        imageView.imageScaling = .scaleProportionallyUpOrDown
        
        let titleFrame = NSRect(x: 40, y: 20, width: 220, height: 16)
        titleLabel = NSTextField(frame: titleFrame)
        titleLabel.backgroundColor = .clear
        titleLabel.isBezeled = false
        titleLabel.isEditable = false
        titleLabel.font = NSFont.systemFont(ofSize: 14)
        titleLabel.lineBreakMode = .byTruncatingTail
        
        let infoProgressFrame = NSRect(x: 40, y: 4, width: 220, height: 14)
        infoLabel = NSTextField(frame: infoProgressFrame)
        infoLabel.backgroundColor = .clear
        infoLabel.isBezeled = false
        infoLabel.isEditable = false
        infoLabel.font = NSFont.systemFont(ofSize: 11)
        
        progressBar = NSProgressIndicator(frame: infoProgressFrame)
        progressBar.minValue = 0
        progressBar.maxValue = 100
        progressBar.isIndeterminate = false
        
//        An indeterminate progress indicator is something like a spinner that shows
//        the app is busy but doesn’t provide any information about the state of
//        progress. This progress bar will NOT be indeterminate, so that it can show
//        what percentage of the task is complete.
        
        super.init(frame: frameRect)
        
        // add subviews
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(infoLabel)
        addSubview(progressBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if let task = task {
            let color = task.status.textColor
            
            imageView.image = NSImage(
                systemSymbolName: task.status.iconName,
                accessibilityDescription: task.status.statusText
            )
            imageView.contentTintColor = color
            
            titleLabel.stringValue = task.title
            titleLabel.textColor = color
            
            infoLabel.stringValue = task.status.statusText
            infoLabel.textColor = color
            
            switch task.status {
            case .notStarted:
                progressBar.isHidden = true
            case .inProgress:
                progressBar.doubleValue = task.progressPercent
                progressBar.isHidden = false
            case .complete:
                progressBar.isHidden = true
            }
        }
    }
}
