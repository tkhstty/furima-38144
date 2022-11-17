function preview() {
  const previews = document.querySelector('.item-image-previews')

  // 投稿枚数の制限
  const imageLimits = 5

  // 画像プレビュー追加処理
  const buildImagePreview = (dataIndex, imageBlob) => {
    const imagePreviewWrapper = document.createElement('div')
    imagePreviewWrapper.setAttribute('class', 'item-image-wrapper')
    imagePreviewWrapper.setAttribute('data-index', dataIndex)
    const imagePreviewContent = document.createElement('img')
    imagePreviewContent.setAttribute('class', 'item-image-preview')
    imagePreviewContent.setAttribute('src', imageBlob)
    imagePreviewWrapper.appendChild(imagePreviewContent)
    previews.appendChild(imagePreviewWrapper)
  }

  // フォームの追加処理
  const buildImageInput = () => {
    // 新規フォームの追加
    const imageInputButton = document.querySelector('.click-upload')
    const newImageInput = document.createElement('input')
    const lastImageInput = document.querySelector('input[name="item[images][]"]:last-child')
    const nextDataIndex = Number(lastImageInput.getAttribute('data-index')) + 1
    newImageInput.setAttribute('type', 'file')
    newImageInput.setAttribute('name', 'item[images][]')
    newImageInput.setAttribute('data-index', nextDataIndex)
    newImageInput.setAttribute('id', `item-image[${nextDataIndex}]`)
    imageInputButton.appendChild(newImageInput)

    // 追加したフォームでもプレビュー及びフォーム生成を実行
    newImageInput.addEventListener('change', changedImageInput)
  }

  // プレビューとimageInputの削除
  const deleteImage = (dataIndex) => {
    const deleteImagePreview = document.querySelector(`.item-image-wrapper[data-index="${dataIndex}"]`)
    deleteImagePreview.remove()
    const deleteImageInput = document.querySelector(`input[data-index="${dataIndex}"]`)
    deleteImageInput.remove()

    // 画像の枚数が最大時、画像を削除すると改めて新規imageInputを生成
    const imageCount = document.querySelectorAll('.item-image-preview').length
    if (imageCount == imageLimits - 1) buildImageInput() 
  }

  // 画像が添付された際の処理（プレビューとフォームの追加）
  const changedImageInput = (e) => {
    const dataIndex = e.target.getAttribute('data-index')
    const imageFile = e.target.files[0]

    // ファイルを選択しなかった場合、プレビュー削除
    if (!imageFile) {
      deleteImage(dataIndex)
      return null
    }

    // ファイルを選択した場合のみURLを付与
    const imageBlob = window.URL.createObjectURL(imageFile)

    // 画像の差し替え処理
    const alreadyPreview = document.querySelector(`.item-image-wrapper[data-index="${dataIndex}"]`)
    if (alreadyPreview) {
      const alreadyPreviewImage = alreadyPreview.querySelector("img")
      alreadyPreviewImage.setAttribute('src', imageBlob)
      return null
    }

    buildImagePreview(dataIndex, imageBlob)

    // 画像の枚数制限に当たらない場合のみ、新しいimageInputを生成
    const imageCount = document.querySelectorAll(".item-image-preview").length
    if (imageCount < imageLimits) buildImageInput()
  }

  const imageInput = document.querySelector('input[name="item[images][]"]')
  imageInput.addEventListener('change', changedImageInput)
}

window.addEventListener('load', preview)