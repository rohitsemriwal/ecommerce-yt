const OrderModel = require('./../models/order_model');

const OrderController = {

    createOrder: async function(req, res) {
        try {
            const { user, items } = req.body;
            const newOrder = new OrderModel({
                user: user,
                items: items
            });
            await newOrder.save();

            return res.json({ success: true, data: newOrder, message: "Order created!" });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    },

    fetchOrdersForUser: async function(req, res) {
        try {
            const userId = req.params.userId;
            const foundOrders = await OrderModel.find({
                "user.id": userId
            });
            return res.json({ success: true, data: foundOrders });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    },

    updateOrderStatus: async function(req, res) {
        try {
            const { orderId, status } = req.body;
            const updatedOrder = await OrderModel.findOneAndUpdate(
                { _id: orderId },
                { status: status },
                { new: true }
            );
            return res.json({ success: true, data: updatedOrder });
        }
        catch(ex) {
            return res.json({ success: false, message: ex });
        }
    }

};

module.exports = OrderController;