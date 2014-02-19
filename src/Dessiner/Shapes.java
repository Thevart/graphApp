
//²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²TESTING Class²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²²
package Dessiner;

import javax.swing.*;

import com.mxgraph.swing.mxGraphComponent;
import com.mxgraph.view.mxGraph;

/**
 *
 * 
 */
public class Shapes {

    /**
     *
     */
    public static void main(String args[]) {
        Draw draw = new Draw(10, 10);
        JFrame frame = new JFrame();
        frame.setTitle("youpiiii");
        frame.setSize(400, 500);
        frame.add(draw);
        frame.setVisible(true);
    }
}
