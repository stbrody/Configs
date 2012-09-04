prompt = function() {
    var rsStates = ["STARTUP", "PRIMARY", "SECONDARY", "RECOVERING", "FATAL", "STARTUP2", "UNKNOWN", "ARBITER", "DOWN", "ROLLBACK"];

    if (typeof(db) == "undefined") {
        return "> ";
    }

    var isMongos = db.adminCommand('isdbgrid').isdbgrid || false;
    var isMaster = db.adminCommand('ismaster');
    var now = new Date();
    var timeString = now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();

    if (isMaster.ismaster && !isMongos) {
        // TODO: note config servers somehow.
        return db + "[" + timeString + "]> ";
    }
    else if (isMaster.secondary) {
        return "(" + db + ")[" + timeString +"]> "; // parentheses indicate secondary
    }

    var result = db.adminCommand({replSetGetStatus : 1});
    if ( result.ok ) {
        return rsStates[result.myState]+":"+db+ "[" + timeString +"]> ";
    }
    if ( isMongos ) {
        return "*" + db + "*[" + timeString + "]> "; // asterisks indicate mongos
    }

    return db + "[" + timeString + "]> ";
};
