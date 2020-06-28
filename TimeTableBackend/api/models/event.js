const mongoose = require('mongoose');

const eventSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    title : {type: String , required : true},
    date: { type: String , required : true },
    start_time : { type: String , required : true },
    end_time: { type: String , required : true }
});

module.exports = mongoose.model('EventsList' , eventSchema);