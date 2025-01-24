String getArSitesInfo(String siteName){
  switch (siteName){
    case 'castle_of_loarre':
      return 'The Castle of Loarre is a Romanesque fortress in northern Spain, located near Huesca in Aragón. Built in the 11th century, it served as a military stronghold during the Christian reconquest of the Iberian Peninsula. The castle is renowned for its strategic hilltop location, well-preserved walls, towers, and a Romanesque church. It is considered one of the best-preserved castles in Europe and has been featured in films like Kingdom of Heaven.';
    case 'drawing_room':
      return 'Welcome to The Hallwyl Museum in Stockholm, Sweden. Once the home of Walther and Wilhelmina von Hallwyl. The Great Drawing Room has the most sumptuous interior in the house. It was a setting for entertaining, music and dancing. The room is inspired by the magnificent Baroque style of the late 17th century. This style provided a suitable opulent backdrop for big parties.';
    case 'empire_state_building':
      return 'The Empire State Building is a 102-story Art Deco skyscraper in Midtown Manhattan, New York City. It was designed by Shreve, Lamb & Harmon and completed in 1931. The building has a roof height of 1,250 feet (380 m) and stands a total of 1,454 feet (443.2 m) tall, including its antenna. Its name is derived from "Empire State", the nickname of the state of New York.';
    case 'taj_mahal':
      return 'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the Yamuna river in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor, Shah Jahan, to house the tomb of his favorite wife, Mumtaz Mahal. The tomb is the center piece of a 17-hectare (42-acre) complex, which includes a mosque and a guest house, and is set in formal gardens bounded on three sides by a crenellated wall.';
    case 'titanic_wreck':
      return 'The wreck of the RMS Titanic lies at a depth of about 12,500 feet (3.8 km; 2.37 mi), about 370 miles (600 km) south-southeast off the coast of Newfoundland. It lies in two main pieces about a third of a mile (600 m) apart. The bow is still recognizable with many preserved interiors, despite deterioration and damage sustained hitting the sea floor. The stern is completely ruined.';
    case 'kings_hall':
      return 'The King’s hall is the most lavish of all the rooms at Skokloster Castle, Sweden. It is situated in the middle of the Wrangel apartments, between the rooms of the count and those of the countess. In the Wrangel era the room was called ”The Everyday Diningroom”. In the 18th Century, when portraits of kings and queens started filling up the walls, it became known as ”The King’s Hall”.';
    default:
      return 'No information available';
  }
}