const { db } = require('../util/admin');

async function getPatients(ids) {
  let queries = [];
  ids.forEach(id => {
    //console.log(id);
    queries.push(
      db
        .collection('patient')
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
          console.log('patient details has not been found');
        }
      });
    })
    .catch(e => {
      console.error(e);
      errors.push(e);
    });

  return {
    errors: errors,
    results: results
  };
}

module.exports = {
  getPatients
};
