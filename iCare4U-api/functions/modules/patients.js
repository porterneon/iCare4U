const { db } = require("../util/admin");

async function getPatients(ids) {
  let queries = [];
  ids.forEach(id => {
    queries.push(db.doc(`/patient/${id}`).get());
  });

  var errors = [];
  var results = [];

  return Promise.all(queries)
    .then(items => {
      items.forEach(element => {
        results.push(element.data());
      });

      return {
        errors: errors,
        results: results
      };
    })
    .catch(e => {
      console.error(e);
      errors.push(e);
      return {
        errors: errors,
        results: results
      };
    });
}

module.exports = {
  getPatients
};
