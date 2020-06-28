const express = require("express");
const router = express.Router();

const EventsController = require("../controllers/events");


router.get("/", EventsController.get_all_events);

router.get("/:eventId" , EventsController.get_event);

router.post("/", EventsController.events_create_event);

router.delete("/:eventId", EventsController.events_delete_event);


module.exports = router;
