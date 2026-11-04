package de.tum.in.ase;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.jupiter.api.Test;

class SortingTest {

    @Test
    void sortsAscending() {
        assertThat(MainKt.sorted(List.of(3, 1, 2))).containsExactly(1, 2, 3);
    }
}
