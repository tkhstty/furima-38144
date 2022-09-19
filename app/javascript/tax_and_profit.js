function taxAndProfit() {
  const price = document.getElementById('item-price')
  price.addEventListener('input', () => {
    const tax = document.getElementById('add-tax-price')
    const profit = document.getElementById('profit')
    tax.innerHTML = Math.trunc(price.value * 0.1)
    profit.innerHTML = price.value - tax.innerHTML
  })
}

window.addEventListener('load', taxAndProfit)