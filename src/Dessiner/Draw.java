//```````````````````````````````````Elie Abboud
//²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²Testing Class²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
package Dessiner;

import java.awt.*;
import javax.swing.*;

//cette classe nous permet de dessiner
public class Draw extends JPanel {

    //déclaration des variables
    int x, y;

    public Draw(int x, int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public void paintComponent(Graphics g) {
        System.out.println("paintComponent  " + this.x + " " + this.y);
        super.paintComponent(g);
        this.setBackground(Color.WHITE);
        g.setColor(Color.BLUE);
        g.fillOval(0, 0, 20, 20);
        g.dispose();
    }
}
