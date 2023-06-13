const razorpay = require('razorpay');

const instance = new razorpay({
    key_id: 'rzp_test_09AVqbkjcSmzKv',
    key_secret: 'D9vu4DHGVeLiJBuibKYdBPiw'
});

module.exports = instance;