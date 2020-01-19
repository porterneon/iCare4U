const { db } = require("../util/admin");

async function getSchedules(ids) {
  let queries = [];
  ids.forEach(id => {
    //console.log(id);
    queries.push(
      db
        .collection("schedules")
        .doc(id)
        .get()
    );
  });

  var errors = [];
  var results = [];

  await Promise.all(queries)
    .then(items => {
      items.forEach(element => {
        if (element.data() != null) {
          let p = element.data();
          p.patientId = element.id;
          results.push(p);
        } else {
          console.log("schedule details not found");
        }
      });
    })
    .catch(e => {
      console.error(e);
      errors.push(e);
    });

  return {
    errors: errors,
    results: results,
    valid: Object.keys(errors).length === 0 ? true : false
  };
}

module.exports = {
  getSchedules
};
