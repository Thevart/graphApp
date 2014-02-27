package Dessiner;

import java.awt.Color;
import java.awt.Graphics;

/*x et y sont les coordonnées du sommet haut gauche, dx: largeur, dy: longueur
 * on a aussi mis les caractétristiques d'un sommet comme couleur, forme et Label. cette 
 * classe est la classe mère des classes "Carre", "Cercle" et "Rectangle". elle nous aide 
 * à définir les variables une seul fois de manière qu'ils seront héritées par les
 * classes filles.
 */
public class Sommet {

    public int x;
    public int y;
    public int dx;
    public int dy;
    public String couleurSommet;
    public String formeSommet;
    public int labelSommet;
    public Boolean selectionne = false;

    //constructeur de la classe
    public Sommet(int x, int y, int dx, int dy, String couleurSommet, String formeSommet, int labelSommet) {
        this.x = x;
        this.y = y;
        this.dx = dx;
        this.dy = dy;
        this.couleurSommet = couleurSommet;
        this.formeSommet = formeSommet;
        this.labelSommet = labelSommet;
    }

    public void dessinerSommet(Graphics g) {
        switch (this.formeSommet) {
            case "Rectangle":
                g.fillRect(x, y, dx, dy);
                break;

            case "Carre":
                g.fillRect(x, y, dx, dx);
                break;

            case "Cercle":
                g.fillOval(x, y, dx, dy);
                break;
        }
    }

    //pour dessiner les labels dans les sommets
    public void dessinerLabels(Graphics g) {
        g.setColor(Color.WHITE);
        String label = Integer.toString(labelSommet);
        g.drawString(label, x + dx / 4, y + dy / 2);
    }
}// end class sommet
