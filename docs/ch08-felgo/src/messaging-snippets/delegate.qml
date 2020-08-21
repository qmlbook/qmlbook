delegate: SimpleRow {
            image.radius: image.height
            image.fillMode: Image.PreserveAspectCrop
            autoSizeImage: true
            style.showDisclosure: false
            imageMaxSize: dp(48)
            detailTextItem.maximumLineCount: 1
            detailTextItem.elide: Text.ElideRight
}
