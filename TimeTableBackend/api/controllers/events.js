const Event = require("../models/event");
const mongoose = require("mongoose");

exports.events_create_event = (req, res, next) => {
  const events = {
    title: req.body.title,
    start_time: req.body.start_time,
    end_time: req.body.end_time,
    date: req.body.date,
  };
  const event = new Event({
    _id: mongoose.Types.ObjectId(),
    title: req.body.title,
    date: req.body.date,
    start_time: req.body.start_time,
    end_time: req.body.end_time,
  });
  event
    .save()
    .then((result) => {
      console.log(result);
      res.status(200).json({
        message: "Event Created",
        createdEvent: {
          _id: result._id,
          title: result.title,
          date: result.date,
          start_time: result.start_time,
          end_time: result.end_time,
        },
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({
        message: "failed to create event",
        location: "events.js",
      });
    });
};

exports.get_all_events = (req, res, next) => {
  Event.find()
    .exec()
    .then((doc) => {
      const response = {
        count: doc.length,
        events: doc.map((docs) => {
          return {
            _id : docs._id,
            title: docs.title,
            date: docs.date,
            start_time: docs.start_time,
            end_time: docs.end_time,
          };
        }),
      };
      res.status(200).json(response);
    })
    .catch((err) => {
      console.log(err);
      res.status(404).json({
        error: err,
        message: "Error occured in get all events",
      });
    });
};

exports.get_event = (req, res, next) => {
    const _id = req.params.eventId;
    Event.findById(_id)
    .exec()
    .then((doc) => {
        console.log("from database ", doc);
        if(doc) {
            res.status(200).json({
                event: doc
            });
        } else {
            res.status(404).json({
                message: "No valid entry"
            });
        }
    })
    .catch((err) => {
        console.log(err);
        res.status(500).json({
            message: "Error",
            error: err
        });
    });
};

exports.events_delete_event = (req , res , next) => {
  const id = req.params.eventId;
  Event.deleteOne({_id:id})
    .exec()
    .then((result) => {
      res.status(200).json(result)
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({
        error: err
      });
    });
};