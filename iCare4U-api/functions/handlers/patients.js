const { admin, db } = require("../util/admin");

exports.getAllPatients = async (req, res) => {
    try{
        const data = await db.collection("patient").get();

        let items = [];
        data.docs.forEach(doc => {
            items.push(doc.data());
        });

        return res.status(200).json(items);
    }
    catch(e){
        return res.status(500).json(e);
    }
};

exports.getPatientDetails = async (req, res) => {
    let patientDetails = {};
    try{
        console.log(req.params);
        const data = await db.doc(`/patient/${req.params.patientId}`).get();

        //console.log(data.data());
        if (data){
            patientDetails.patient = data.data();
            return res.status(200).json(patientDetails);
        }
        else{
            return res.status(404).json({ errror: "Patient not found" });
        }
    }
    catch(e){
        return res.status(500).json(e);
    }
};