const { db } = require("../util/admin");

async function getMedicines(ids) {
  let queries = [];
  ids.forEach(id => {
    //console.log(id);
    queries.push(
      db
        .collection("medicines")
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

          console.log(p);
        } else {
          console.log("medicine details not found");
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
  getMedicines
};
