
function populateCartTotal() {
    let total = 0
    $('.product-total').each(function() { total += $(this).data('total') })
    $('#cart-total').html(`$${total}.00`)
}

populateCartTotal()

// handle product total update on quantity change
$(document).on("click", ".stepper-arrow" , function(event) {
    const tableRow = $(this).closest('tr')
    
    const productPrice = tableRow.find('.product-price').data('price')
    const productQuantity = tableRow.find('.stepper-input').val()
    const productTotal = tableRow.find('.product-total')
    
    productTotal.data('total', productQuantity * productPrice)
    productTotal.html(`$${productQuantity * productPrice}.00`)

    populateCartTotal()
});