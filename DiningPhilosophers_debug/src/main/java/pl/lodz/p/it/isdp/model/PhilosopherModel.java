package pl.lodz.p.it.isdp.model;

import java.util.concurrent.ThreadLocalRandom;

/**
 * Model filozofa.
 */
public class PhilosopherModel {

    private static final int MAX_EAT_TIME = 20;
    private static final int MAX_REST_TIME = 30;
    private static final int MIN_REST_TIME = MAX_REST_TIME / 2;
    private boolean isEating = false;
    private long mealsNumber;
    private long restsNumber;
    private int time;
    private int id;

    public PhilosopherModel(final int id) {
        this.id = id;
    }

    public int getLeftFork() {
        return id - 1;
    }

    public int getRightFork() {
        return id;
    }

    public void eating() throws InterruptedException {
        isEating = true;
        mealsNumber++;
        time = ThreadLocalRandom.current().nextInt(MAX_EAT_TIME);
        System.out.println(this);
        Thread.sleep(time);
    }

    public void resting() throws InterruptedException {
        isEating = false;
        restsNumber++;
        time = ThreadLocalRandom.current().nextInt(MIN_REST_TIME, MAX_REST_TIME);
        System.out.println(this);
        Thread.sleep(time);
    }

    public long getMealsNumber() {
        return mealsNumber;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("Wątek reprezentujący filozofa " + id + " obecenie ");
        if (isEating) {
            sb.append("je posiłek ").append(mealsNumber);
        } else {
            sb.append("odpoczywa ").append(restsNumber);
        }
        sb.append(" przez czas ").append(time);
        sb.append(" ms");
        return sb.toString();
    }
}
