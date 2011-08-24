states = ["STARTUP", "PRIMARY", "SECONDARY", "RECOVERING", "FATAL", "STARTUP2", "UNKNOWN", "ARBITER", "DOWN", "ROLLBACK"]

prompt = function() {
    if (typeof(db) == "undefined") {
        return "> "
    }
    result = db.isMaster();
    now = new Date();
    if (result.ismaster) {
        return db + "[" + now.getHours()+":"+now.getMinutes()+":"+now.getSeconds() + "]> ";
    }
    else if (result.secondary) {
        return "(" + db + ")[" + now.getHours()+":"+now.getMinutes()+":"+now.getSeconds() +"]> ";
    }
    result = db.adminCommand({replSetGetStatus : 1})
    return states[result.myState]+":"+db+ "[" + now.getHours()+":"+now.getMinutes()+":"+now.getSeconds() +"]> ";
}
