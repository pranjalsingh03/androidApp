// class ClassHelper {
//   static String getFullClassName(int classNo) {
//     switch (classNo) {
//       case 1:
//         return '1st';
//       case 2:
//         return '2nd';
//       case 3:
//         return '3rd';
//       default:
//         return '${classNo}th';
//     }
//   }
// }


// String convertToOrdinal(String sclassName) {
//   if(sclassName.isEmpty)return '';
//   int classNumber = int.parse(sclassName); // Parse string to integer

//   if (classNumber >= 11 && classNumber <= 13) {
//     // Special case for 11th, 12th, 13th
//     return "${classNumber}th";
//   }

//   // Determine ordinal suffix
//   switch (classNumber % 10) {
//     case 1:
//       return "${classNumber}st";
//     case 2:
//       return "${classNumber}nd";
//     case 3:
//       return "${classNumber}rd";
//     default:
//       return "${classNumber}th";
//   }
// }

