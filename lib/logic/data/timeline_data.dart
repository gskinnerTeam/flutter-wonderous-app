import 'package:json_annotation/json_annotation.dart';
import 'package:wonders/logic/data/artifact_data.dart';

class TimelineData {
  TimelineData({required this.artifacts, required this.events});
  final List<ArtifactData> artifacts;
  final List<TimelineEvent> events;
}

class TimelineEvent {
  TimelineEvent({required this.title, required this.string, required this.image, required this.year});
  final int year;
  final String title;
  final String string;
  final String image;
}

Map<int, String> globalEvents = {
  -2900: 'First known use of papyrus by Egyptians',
  -2700: 'The Old Kingdom begins in Egypt',
  -2600: 'Emergence of Mayan culture in the Yucatán Peninsula',
  -2560: 'King Khufu completes the Great Pyramid of Giza',
  -2500: 'The mammoth goes extinct',
  -2200: 'Completion of Stonehenge',
  -2000: 'Domestication of the horse',
  -1800: 'Alphabetic writing emerges',
  -890: 'Home writes the Iliad and the Odyssey',
  -776: 'First recorded Ancient Olympic Games',
  -753: 'Founding of Rome',
  -447: 'Building of the Parthenon at Athens started',
  -427: 'Birth of Greek Philosopher Plato',
  -322: 'Death of Aristotle (61), the first genuine scientist',
  -200: 'Paper is invented in the Han Dynasty',
  -44: 'Death of Julius Caesar; beginning of the Roman Empire',
  -4: 'Birth of Jesus Christ',
  43: 'The Roman Empire enters Great Britain for the first time',
  79: 'Destruction of Pompeii by the volcano Vesuvius',
  455: 'End of the Roman Empire',
  500: 'Tikal becomes the first great Maya city',
  632: 'Death of Muhammad (61), founder of Islam',
  793: 'The Vikings first invade Britain',
  800: 'Gunpowder is invented in China',
  1001: 'Leif Erikson settles during the winter in present-day eastern Canada',
  1077: 'The Construction of the Tower of London begins',
  1117: 'The University of Oxford is founded',
  1199: 'Europeans first use compasses',
  1227: 'Death of Genghis Khan (65)',
  1337: 'The Hundred Years\' War begins as England and France struggle for dominance.',
  1347:
      'The first of many concurrences of the Black Death plague, believed to have wiped out as many as 50% of Europe\'s population by its end',
  1428: 'Birth of the Aztec Empire in Mexico',
  1439: 'Johannes Gutenberg invents the printing press',
  1492: 'Christopher Columbus reaches the New World',
  1760: 'The industrial revolution begins',
  1763: 'Development of the Watt steam engine',
  1783: 'End of the American War of Independence from the British Empire',
  1789: 'The French Revolution begins',
  1914: 'World War I',
  1929: 'Black Tuesday signals the beginning of the Great Depression',
  1939: 'World War II',
  1957: 'launch of Sputnik 1 by the Soviet Union',
  1969: 'Apollo 11 mission lands on the moon',
};
