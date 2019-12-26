package pl.lodz.p.it.isdp;

import pl.lodz.p.it.isdp.model.PhilosopherModel;
import pl.lodz.p.it.isdp.model.TableModel;

/**
 * Aplikacja przygotowana do celów diagnostycznych, która prezentuje przykładowe
 * rozwiązanie problemu ucztujących filozofów. Krótki opis problemu: przy
 * okrągłym stole zasiadają filozofowie tak, by pomiędzy sąsiadującymi
 * filozofami znajdował się na stole dokłanie jeden widelec. Każdy filozof
 * naprzemiennie wykonuje dwie czynności: jedzenie posiłku (eating) oraz
 * odpoczynek (resting). Aby rozpocząć jedzenie filozof potrzebuje dwóch
 * najbliższych mu widelców jednocześnie, dodatkowo filozof nie może odłożyć
 * podniesionego już widelca, do czasu kiedy nie zje posiłku. Zatem dwóch
 * sąsiadujących ze sobą przy stole filozofów nie może jednocześnie jeść
 * posiłku. Filozofowie nie mogą też wzajemnie się komunikować, w synchronizacji
 * ich działań należy wykorzystać dedykowane mechanizmy synchronizacji.
 *
 * Przygotowany kod aplikacji zawiera błąd powodujący wystąpienie wzajemnej
 * blokady (deadlock), której przyczynę należy zdiagnozować i poprawić z
 * wykorzystaniem technik diagnostycznych stosując nadzorowane uruchomienie
 * programu (debug).
 *
 * Diagnostykę należy przeprowadzić z wykorzystaniem trybu debug w środowisku
 * IDE, w szczególności sprawdzając funkcjonalność (Debug->Check for Deadlock).
 *
 */
public class Start {

    private static Thread[] threads;

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Brak podanej liczby całkowitej jako argumentu wywołania.");
            System.exit(1);
        }
        try {
            final int PHILOSOPHERS_NUMBER = Integer.parseInt(args[0].trim());
            threads = new Thread[PHILOSOPHERS_NUMBER];
            TableModel table = new TableModel(PHILOSOPHERS_NUMBER);
            for (int i = 0; i < PHILOSOPHERS_NUMBER; i++) {
                PhilosopherModel philosopher = new PhilosopherModel(i + 1);
                threads[i] = new Thread(new PhilosopherRunnable(table, philosopher));
                threads[i].setName("Wątek reprezentujący filozofa " + (i + 1));
                threads[i].start();
            }
        } catch (NumberFormatException nfe) {
            System.err.println("Podany argument nie jest liczbą.");
            System.exit(2);
        } catch (Throwable ex) {
            System.err.println("Wystąpił wyjątek typu: " + ex.getClass().getName() + " Szczegóły: " + ex.getMessage());
            System.exit(3);
        }
    }
}
