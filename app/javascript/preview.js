function preview() {
  const previews = document.querySelector('.item-image-previews')
  const imageInput = document.querySelector('input[name="item[image]"]')

  // 画像が添付されたら以下の処理を実行
  imageInput.addEventListener('change', (e) => {

    // 既に画像がある場合は削除
    const alreadyPreview = document.querySelector('.item-image-wrapper')
    if (alreadyPreview) {
      alreadyPreview.remove()
    }

    // プレビュー追加処理
    const imageFile = e.target.files[0]
    const imageBlob = window.URL.createObjectURL(imageFile)
    const imagePreviewWrapper = document.createElement('div')
    imagePreviewWrapper.setAttribute('class', 'item-image-wrapper')
    const imagePreviewContent = document.createElement('img')
    imagePreviewContent.setAttribute('class', 'item-image-preview')
    imagePreviewContent.setAttribute('src', imageBlob)
    imagePreviewWrapper.appendChild(imagePreviewContent)
    previews.appendChild(imagePreviewWrapper)
  })
}

window.addEventListener('load', preview)