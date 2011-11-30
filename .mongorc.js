states = ["STARTUP", "PRIMARY", "SECONDARY", "RECOVERING", "FATAL", "STARTUP2", "UNKNOWN", "ARBITER", "DOWN", "ROLLBACK"]

prompt = function() {
    if (typeof(db) == "undefined") {
        return "> "
    }
    result = db.isMaster();
    now = new Date();
    timeString = now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
    if (result.ismaster) {
        return db + "[" + timeString + "]> ";
    }
    else if (result.secondary) {
        return "(" + db + ")[" + timeString +"]> ";
    }
    result = db.adminCommand({replSetGetStatus : 1})
    return states[result.myState]+":"+db+ "[" + timeString +"]> ";
}
