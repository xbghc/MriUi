#include <dcmtk/dcmdata/dctk.h>

#include "include/patient.h"

PatientManager::PatientManager(QObject *parent) : QObject(parent)
{
}

QJsonArray PatientManager::loadAllPatients(){
    
}

void PatientManager::newPatient(QJsonObject& patientInfo){
    char uid[100];
    DcmFileFormat fileformat;
    DcmDataset *dataset = fileformat.getDataset();
    dataset->putAndInsertString(DCM_SOPClassUID, UID_SecondaryCaptureImageStorage);
    dataset->putAndInsertString(DCM_SOPInstanceUID, dcmGenerateUniqueIdentifier(uid, SITE_INSTANCE_UID_ROOT));
    dataset->putAndInsertString(DCM_PatientName, "Doe^John");
    /* ... */
    dataset->putAndInsertUint8Array(DCM_PixelData, pixelData, pixelLength);
    OFCondition status = fileformat.saveFile("test.dcm", EXS_LittleEndianExplicit);
    if (status.bad())
    cerr << "Error: cannot write DICOM file (" << status.text() << ")" << endl;
}
