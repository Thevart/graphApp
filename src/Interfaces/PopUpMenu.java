package Interfaces;

import Dessiner.Sommet;
import java.awt.event.*;
import javax.swing.*;

public class PopUpMenu {

    JPopupMenu sommetPM;
    JMenu couleurM;
    JMenu formeM;
    JMenuItem delete;
    JMenuItem Bleu;
    JMenuItem Rouge;
    JMenuItem Gris;
    JMenuItem Carre;
    JMenuItem Cercle;
    JMenuItem Rectangle;

    //constructeur de la classe qui crée le popup menu avec ses menus et menu items.
    public PopUpMenu(JComponent comp, int x, int y) {
        sommetPM = new JPopupMenu();
        couleurM = new JMenu("Couleur");
        formeM = new JMenu("Forme");
        delete = new JMenuItem("Delete");
        Bleu = new JMenuItem("Bleu");
        Rouge = new JMenuItem("Rouge");
        Gris = new JMenuItem("Gris");
        Carre = new JMenuItem("Carre");
        Cercle = new JMenuItem("Cercle");
        Rectangle = new JMenuItem("Rectangle");
        sommetPM.add(couleurM);
        sommetPM.add(formeM);
        sommetPM.add(delete);
        couleurM.add(Bleu);
        couleurM.add(Rouge);
        couleurM.add(Gris);
        formeM.add(Carre);
        formeM.add(Cercle);
        formeM.add(Rectangle);
        sommetPM.show(comp, x, y);
    }

    /**
     * c'est la méthode qui nous permet d'ajouter des action listener aux menu
     * items du JPopupMenu
     */
    public void choisirMI(final Sommet sommet) {

        Bleu.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                sommet.couleurSommet = "BLUE";
                DessinerFrame.panelDessin.myRepaint();
            }
        });

        Rouge.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                sommet.couleurSommet = "RED";
                DessinerFrame.panelDessin.myRepaint();
            }
        });

        Gris.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                sommet.couleurSommet = "GRAY";
                DessinerFrame.panelDessin.myRepaint();
            }
        });

        Carre.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                sommet.formeSommet = "Carre";
                DessinerFrame.panelDessin.myRepaint();
            }
        });

        Cercle.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                sommet.formeSommet = "Cercle";
                DessinerFrame.panelDessin.myRepaint();
            }
        });

        Rectangle.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                sommet.formeSommet = "Rectangle";
                DessinerFrame.panelDessin.myRepaint();
            }
        });

        delete.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                DessinerFrame.panelDessin.deleteSommet(sommet);
            }
        });

    }// end choisirMI
}// end class PopUpMenu
