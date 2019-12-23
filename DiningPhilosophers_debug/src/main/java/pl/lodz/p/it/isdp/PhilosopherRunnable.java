package pl.lodz.p.it.isdp;

import pl.lodz.p.it.isdp.model.PhilosopherModel;
import pl.lodz.p.it.isdp.model.TableModel;

/**
 *
 * Zadanie realizujące funkcjonalność filozofa siedzącego przy stole.
 */
public class PhilosopherRunnable implements Runnable {

    private TableModel table;
    private PhilosopherModel philosopher;

    public PhilosopherRunnable(TableModel table, PhilosopherModel philosopher) {
        this.table = table;
        this.philosopher = philosopher;
    }

    @Override
    public void run() {
        try {
            while (true) {
                //rezerwacja lewego widelca poprzez założenie blokady wewnętrznej na reprezentującym go obiekcie
                synchronized (table.getFork(philosopher.getLeftFork())) {
                    System.out.println(Thread.currentThread().getName() + " pobrał lewy widelec i czeka na pobranie widelca prawego");
                    //rezerwacja prawego widelca poprzez założenie blokady wewnętrznej na reprezentującym go obiekcie
                    synchronized (table.getFork(philosopher.getRightFork())) {
                        philosopher.eating();
                    }
                }
                philosopher.resting();
            }
        } catch (InterruptedException ie) {
            System.err.println(Thread.currentThread().getName() + " zakończył działanie.");
        }
    }
}