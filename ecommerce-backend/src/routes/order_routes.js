const OrderRoutes = require('express').Router();
const OrderController = require('./../controllers/order_controller');

OrderRoutes.get("/:userId", OrderController.fetchOrdersForUser);
OrderRoutes.post("/", OrderController.createOrder);
OrderRoutes.put("/updateStatus", OrderController.updateOrderStatus);

module.exports = OrderRoutes;