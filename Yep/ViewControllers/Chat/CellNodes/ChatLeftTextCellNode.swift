//
//  ChatLeftTextCellNode.swift
//  Yep
//
//  Created by NIX on 16/7/5.
//  Copyright © 2016年 Catch Inc. All rights reserved.
//

import UIKit
import YepKit
import AsyncDisplayKit

class ChatLeftTextCellNode: ChatLeftBaseCellNode {

    static let textAttributes = [
        NSForegroundColorAttributeName: UIColor.blackColor(),
        NSFontAttributeName: UIFont.chatTextFont(),
    ]

    lazy var bubbleNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.layerBacked = true
        node.clipsToBounds = true
        node.cornerRadius = 20
        node.backgroundColor = UIColor.leftBubbleTintColor()
        return node
    }()

    lazy var textNode = ASTextNode()

    override init() {
        super.init()

        addSubnode(bubbleNode)
        addSubnode(textNode)
        textNode.backgroundColor = UIColor.greenColor()
    }

    func configure(withMessage message: Message) {

        self.user = message.fromFriend

        do {
            let text = message.textContent
            textNode.attributedText = NSAttributedString(string: text, attributes: ChatLeftTextCellNode.textAttributes)
        }
    }

    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {

        let textMaxWidth = constrainedSize.width - (15 + ChatBaseCellNode.avatarSize.width + (5 + 7 + 10) + 15)
        textNode.measure(CGSize(width: textMaxWidth, height: CGFloat.max))

        let height = max(textNode.calculatedSize.height + (10 + 10), ChatBaseCellNode.avatarSize.height)

        return CGSize(width: constrainedSize.width, height: height)
    }

    override func layout() {
        super.layout()

        let x = 15 + ChatBaseCellNode.avatarSize.width + (5 + 7 + 10)
        let origin = CGPoint(x: x, y: 10)
        textNode.frame = CGRect(origin: origin, size: textNode.calculatedSize)

        let gap: CGFloat = 10
        bubbleNode.frame = CGRect(x: x - gap, y: 0, width: textNode.calculatedSize.width + (gap + gap), height: calculatedSize.height)
    }
}

