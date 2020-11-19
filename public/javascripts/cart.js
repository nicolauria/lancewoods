// document.querySelector('#add-to-cart').onclick = function(e) {
//     e.preventDefault();

//     const data = {
//         productId: document.querySelector('#product-id').value,
//         quantity: document.querySelector('#quantity').value
//     }

//     fetch('http://localhost:3000/add_to_cart', {
//         method: 'post',
//         body: JSON.stringify(data)
//     }).then(function(response) {
//         return response.json();
//     }).then(function(data) {
//         console.log(data);
//     });
// }