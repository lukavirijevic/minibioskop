import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../models/showtime.dart';

class MoviesProvider extends ChangeNotifier {
  final List<Movie> _movies = [];
  final Map<int, List<Showtime>> _showtimes = {};


  List<Movie> get movies => List.unmodifiable(_movies);
  List<Showtime> showtimesFor(int movieId) => _showtimes[movieId] ?? const [];

  Movie? byId(int id) => _movies.firstWhere((m) => m.id == id, orElse: () => null as Movie);

  void loadMock() {
    if (_movies.isNotEmpty) return;
    _movies.addAll([
      Movie(
        id: 1,
        title: 'Formula 1',
        genre: 'Drama, sportski',
        durationMin: 155,
        rating: 7.9,
        description:
                    'F1 je visokooktanski film od tvoraca Top Gun: Maverick, sa Bradom Pittom kao bivšim F1 vozačem koji se vraća na stazu, sniman tokom stvarnih Grand Prix vikenda. Priča o autsajderima, prijateljstvu i hrabrosti uz dozu romantike nudi jedinstveno, adrenalinsko bioskopsko iskustvo.',
        posterUrl: null,
        posterAsset: 'lib/images/F1.jpg',
        director: 'Joseph Kosinski',
        cast: ['Javier Bardem', 'Brad Pitt', 'Kerry Condon', 'Damson Idris', 'Callie Cooke'],
      ),
      Movie(
        id: 2,
        title: 'Rouzovi',
        genre: 'Komedija',
        durationMin: 105,
        rating: 8.2,
        description:
                    'Savremena filmska verzija klasika ,,Ratovi ruž'', po romanu Vorena Adlera, prati naizgled savršen par Ajvi (Olivija Kolman) i Tea (Benedikt Kamberbač). Dok Teova karijera uzleće, a Ajvine ambicije rastu, iza idealne fasade izbijaju sukobi koji pretvaraju brak u bure baruta.',
        posterUrl: null,
        posterAsset: 'lib/images/Rouzovi.jpg',
        director: 'Jay Roach',
        cast: ['Kate McKinnon', 'Andy Samberg', 'Allison Janney', 'Olivia Colman', 'Benedict Cumberbatch', 'Jamie Demetriou', 'Belinda Bromilow', 'Sunita Mani', 'Ncuti Gatwa', 'Zoe Chao'],
      ),
      Movie(
        id: 3,
        title: 'Uvrnuti petak 2',
        genre: 'Komedija, fantazija',
        durationMin: 111,
        rating: 7.4,
        description:
                    ',,Uvrnuti petak'' je nastavak kultnog filma iz 2003. sa višegeneracijskim obrtom, u kojem se Džejmi Li Kertis i Lindsi Lohan vraćaju kao Tes i En Kolman. Godinama posle prve krize identiteta, En sada ima ćerku i pastorku, a tokom spajanja porodica majka i ćerka ponovo upadaju u haos koji dokazuje da grom može da udari dva puta.',
        posterUrl: null,
        posterAsset: 'lib/images/UvrnutiPetak.jpg',
        director: 'Nisha Ganatra',
        cast: ['Jamie Lee Curtis', 'Mark Harmon', 'Lindsay Lohan', 'Chad Michael Murray', 'Christina Vidal Mitchell', 'Haley Hudson', 'Lucille Soong', 'Stephen Tobolowsky', 'Rosalind Chao'],
      ),
      Movie(
        id: 4,
        title: 'Lilo i Stič 2',
        genre: 'Komedija, akcija, avantura',
        durationMin: 108,
        rating: 6.9,
        description:
                    'Rimejk Diznijevog klasika iz 2002. godine „Lilo i Stič“ je smešna i dirljiva priča o usamljenoj devojci sa Havaja i odbeglom vanzemaljcu koji, njenoj narušenoj porodici, pomaže da se popravi.',
        posterUrl: null,
        posterAsset: 'lib/images/LiloStic.jpg',
        director: 'Dean Fleischer-Camp',
        cast: ['Zach Galifianakis', 'Billy Magnussen', 'Courtney B. Vance', 'Jason Scott Lee', 'Chris Sanders', 'Tia Carrere'],
      ),
      Movie(
        id: 5,
        title: 'Niko 2',
        genre: 'Akcija',
        durationMin: 89,
        rating: 8.4,
        description:
                    'On se vratio, i ovog puta je opasniji nego ikada. Nakon ogromnog uspeha akcionog trilera "NIKO" iz 2021. godine, dobitnik Emi nagrade, Bob Odenkirk ("Niko", "Better Call Saul"), vraća se kao neumoljivi Hač Mansel u dugoiščekivanom novom poglavlju, koje stiže iz studija Universal Pikčers.',
        posterUrl: null,
        posterAsset: 'lib/images/Niko2.jpg',
        director: 'Timo Tjahjanto',
        cast: ['Connie Nielsen', 'Bob Odenkirk', 'John Ortiz', 'Christopher Lloyd', 'Sharon Stone', 'Colin Hanks', 'RZA'],
      ),
      Movie(
        id: 6,
        title: 'Uhvaćen na delu',
        genre: 'Triler, kriminalistički',
        durationMin: 109,
        rating: 7.5,
        description:
                    'Aronofskov triler po kultnom romanu Čarlija Hjustona prati Hanka Tompsona (Austin Butler), bivšeg bejzbol igrača i barmena, kome se život preokreće kada pristane da pričuva komšijinu mačku. U vrtlogu gangstera i haosa, uz devojku (Zoë Kravitz) i niz neočekivanih obrta, Hank se bori da preživi i otkrije zašto je postao meta.',
        posterUrl: null,
        posterAsset: 'lib/images/UhvacenNaDelu.jpg',
        director: 'Darren Aronofsky',
        cast: ['Zoe Kravitz', 'Vincent DOnofrio', 'Regina King', 'Liev Schreiber', 'Matt Smith', 'Austin Butler', 'Carol Kane', 'Griffin Dunne', 'Benito A Martínez Ocasio'],
      ),
      Movie(
        id: 101,
        title: 'Spoj iz snova',
        genre: 'Komedija, romantični, ljubavni',
        durationMin: 116,
        rating: 8.0,
        description:
                    'Savršena provodadžija. Ali, ko je njen gospodin savršeni? Mlada, ambiciozna provodadžika iz Njujorka nađe se razapeta između savršenog partnera i svog nesavršenog bivšeg.',
        posterUrl: null,
        posterAsset: 'lib/images/SpojIzSnova.jpg',
        director: 'Celine Song',
        cast: ['Chris Evans', 'Dakota Johnson', 'Pedro Pascal', 'Marin Ireland', 'Zoe Winters', 'Dasha Nekrasova', 'Louisa Jacobson', 'Lindsey Broad', 'Sawyer Spielberg'],
        comingSoon: true,
      ),
      Movie(
        id: 102,
        title: 'Goli pištolj',
        genre: 'Komedija',
        durationMin: 85,
        rating: 8.9,
        description:
                    'Samo jedan čovek poseduje izuzetne veštine... da predvodi Policijski odred i spase svet! Poručnik Frenk Drebin mlađi (Lijam Nison) ide stopama svog oca u filmu "GOLI PIŠTOLJ", u režiji Akive Šafera (Saturday Night Live, Pop zvezda - Nikad ne odustaj) i produkciji Seta Makfarlana (Ted, Porodični čovek/ Family Guy).',
        posterUrl: null,
        posterAsset: 'lib/images/GoliPistolj.jpg',
        director: 'Akiva Schaffer',
        cast: ['Liam Neeson', 'Paul Walter Hauser', 'Danny Huston', 'Kevin Durand', 'Liza Koshy', 'Pamela Anderson', 'CCH Pounder', 'Cody Rhodes', 'Eddie Yu'],
        comingSoon: true,
      ),
    ]);

    _showtimes[1] = [
      Showtime(movieId: 1, hall: 'Sala 1', times: ['16.00', '18.30', '21.00'])
    ];
    _showtimes[2] = [
      Showtime(movieId: 2, hall: 'Sala 2', times: ['15.00', '19.15'])
    ];
    _showtimes[3] = [
      Showtime(movieId: 3, hall: 'Sala 1', times: ['17.45'])
    ];
    _showtimes[4] = [
      Showtime(movieId: 4, hall: 'Sala 3', times: ['14.00', '20.00'])
    ];
    _showtimes[5] = [
      Showtime(movieId: 5, hall: 'Sala 5', times: ['15.00', '19.30', '22.00'])
    ];
    _showtimes[6] = [
      Showtime(movieId: 6, hall: 'Sala 4', times: ['11.00', '14.30', '17.15'])
    ];
    notifyListeners();
  }
}