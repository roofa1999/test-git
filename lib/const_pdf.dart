import 'package:open_file/open_file.dart';

const getArchivmentFile = "https://drive.google.com/file/d/1_L2sGPkvKDQTgzApnQjIBSD_l0gQtrHj/view?usp=sharing";
const getReportFile = "https://drive.google.com/file/d/1rgdXRV3weBSSzCSghBqYk0Jck1fa0RKJ/view?usp=sharing";
const getTicketFile = "https://drive.google.com/file/d/1fqNiVTtuc1zpoZXQ9npZVAWZhjAPcm3r/view?usp=sharing";
const getStaticksFile = "https://drive.google.com/file/d/1rcjHQ4ld3zNmvjwss3JhmUsytq_Y9e0m/view?usp=sharing";
const getStaticksTechnicalFile = "https://drive.google.com/file/d/10hDB-q-YVoG62mtIMcZCFQhN__4mREZn/view?usp=sharing";


openPDF({filePath})async{
  await OpenFile.open(filePath);
}