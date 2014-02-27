package Dessiner;

import java.awt.Color;
import java.awt.Graphics;
import javax.swing.JPanel;
import java.util.*;

/*c'est le panel qui nous permettera de dessiner, on l'ajoute dans le panel fixe crée
 dans l'interface "DessinerFrame", Cette classe hérite du JPanel de l'API "swing" */
public class PanelDessin extends JPanel {

    /*on a besoin des ArrayList pour stocker les objets comme rectangles, cercles, carrés
     * les variables "couleur" et "forme" sont utilisées pour savoir la couleur et la forme choisies par l'utilisateur chaque
     * fois qu'il dessine. HashMap est utilisée pour maper entre String et Color car on a eu besoin d'affecter
     * la variable "couleur" dans la méthode "g.setColor(map.get(couleur))" qui met à jour la couleur du graphics (vous
     * pouvez consultez la méthode paintComponent() en bas de cette classe pour plus de détails) ,
     */
    public ArrayList<Sommet> sommets;
    public ArrayList<Sommet> sommetsSelection; //cet arraylist stock les sommets selectionnés pour le dessin d'arete
    public ArrayList<Arete> aretes;
    public String couleur = "GRAY"; //couleur par défaut
    public String forme = "Rectangle"; //forme par défaut
    HashMap<String, Color> map = new HashMap<>();
    private int IDArete = 0;

    /*le constructeur est appelé une fois pour créer des nouveaux ArrayList 
     */
    public PanelDessin() {
        sommets = new ArrayList<>();
        sommetsSelection = new ArrayList<>();
        aretes = new ArrayList();
    }

    public void addSommet(Sommet sommet) {
        sommets.add(sommet);
        repaint();
    }

    //à implémenter cette fonctionnalité avec ctrl-z
    public void undo() {
        sommets.remove(sommets.size() - 1);
        repaint();
    }

    /*la methode "modifierCouleur" a pour but de modifier la valeur de la variable "couleur" de cette classe
     et ensuite elle rafraichit le JPanel "PanelDessin" */
    public void modifierCouleur(String couleur) {
        this.couleur = couleur;
        if (sommets.size() > 0) {
            for (Sommet sommet : sommets) {
                sommet.couleurSommet = couleur;
            }
        }
        repaint();
    }

    /*la methode "modifierForme" a pour but de modifier la valeur de la variable "forme" de cette classe
     et ensuite elle rafraichit le JPanel "PanelDessin" */
    public void modifierForme(String forme) {
        this.forme = forme;
        if (sommets.size() > 0) {
            for (Sommet sommet : sommets) {
                sommet.formeSommet = forme;
            }
            repaint();
        }
    }

    //pour dessiner l'arete
    public void dessinArete(Sommet sommet) {
        if (sommetsSelection.isEmpty()) {
            sommetsSelection.add(sommet);
        }
        if (sommetsSelection.size() == 1) {
            if (sommetsSelection.get(0) != sommet) {
                sommetsSelection.add(sommet);
                Sommet src = sommetsSelection.get(0);
                Sommet dest = sommetsSelection.get(1);
                String lbl = src.labelSommet + "," + dest.labelSommet;
                IDArete = ++IDArete;
                Arete arete = new Arete(src.x, src.y, dest.x, dest.y, IDArete, src, dest, "ligneDroite", lbl);
                System.out.println("Label: " + arete.labelArete + " ID: " + arete.IdArete);
                aretes.add(arete);
                sommetsSelection.clear();
                repaint();
            }
        }
    }

    /*cette méthode change la frontière d'un sommet quand il est séléctionné en dessinant 
     une forme identique à ce sommet mais elle sera vide et de contour noir.*/
    public void changerFrontiereSommet(Sommet sommet) {
        Graphics g = this.getGraphics();
        if (sommet.selectionne == true && "Rectangle".equals(sommet.formeSommet)) {
            sommet.selectionne = false;
            repaint();
        } else {
            if (sommet.selectionne == false && "Rectangle".equals(sommet.formeSommet)) {
                sommet.selectionne = true;
                g.setColor(Color.BLACK);
                g.drawRect(sommet.x, sommet.y, sommet.dx, sommet.dy);
            }
        }
        if (sommet.selectionne == true && "Cercle".equals(sommet.formeSommet)) {
            sommet.selectionne = false;
            repaint();
        } else {
            if (sommet.selectionne == false && "Cercle".equals(sommet.formeSommet)) {
                sommet.selectionne = true;
                g.setColor(Color.BLACK);
                g.drawOval(sommet.x, sommet.y, sommet.dx, sommet.dy);
            }
        }
        if (sommet.selectionne == true && "Carre".equals(sommet.formeSommet)) {
            sommet.selectionne = false;
            repaint();
        } else {
            if (sommet.selectionne == false && "Carre".equals(sommet.formeSommet)) {
                sommet.selectionne = true;
                g.setColor(Color.BLACK);
                g.drawRect(sommet.x, sommet.y, sommet.dx, sommet.dx);
            }
        }

    }//end changerFrontiereSommet

    public void myRepaint() {
        repaint();
    }

    // pour vider le JPanel
    public void effacerTout() {
        IDArete = 0;
        if (sommets.size() > 0) {
            sommets.clear();
            repaint();
        }
        if (aretes.size() > 0) {
            aretes.clear();
            repaint();
        }

    }

    //pour effacer un sommet et tous les aretes reliés à lui.
    public void deleteSommet(Sommet sommet) {
        Iterator iter = aretes.iterator();
        while (iter.hasNext()) {
            Arete arete = (Arete) iter.next();
            if (arete.sommetSource.labelSommet == sommet.labelSommet || arete.sommetDest.labelSommet == sommet.labelSommet) {
                iter.remove();
            }
        }
        sommets.remove(sommet);
        repaint();
    }


    /*@Override servira à redéfinir la méthode de JPanel qui s'appelle "paintComponent". 
     * on a fait les mappings entre les couleurs de type "String" et les couleurs de type "Color.GRAY" par exemple.
     * ce qui nous a aidé à affecter une variable à la méthode "g.setColor(map.get(couleur))".
     * Après çelon la forme choisie on dessinera un rectangle, un cercle ou bien un carré. 
     */
    @Override
    protected void paintComponent(Graphics g) {

        super.paintComponent(g);
        this.setBackground(Color.WHITE); //c'est gris par défaut
        map.put("GRAY", Color.GRAY);
        map.put("RED", Color.RED);
        map.put("BLUE", Color.BLUE);

        //quand on repaint on oublie les sommets séléctionnés 
        for (Sommet sommet : sommets) {
            sommet.selectionne = false;
        }

        if (aretes.size() > 0) {
            for (Arete arete : aretes) {
                arete.dessinerArete(g);
            }
        }

        g.setColor(map.get(couleur));
        if (sommets.size() > 0) {

            for (Sommet sommet : sommets) {
                sommet.dessinerSommet(g);
            }

            for (Sommet sommet : sommets) {
                sommet.dessinerLabels(g);
            }
        }//end if

        //si la couleur d'un sommet est différente de la couleur générale donc on le redéssine
        if (sommets.size() > 0) {
            for (Sommet sommet : sommets) {
                if (!sommet.couleurSommet.equals(this.couleur)) {
                    g.setColor(map.get(sommet.couleurSommet));
                    sommet.dessinerSommet(g);
                    sommet.dessinerLabels(g);
                }
            }
        }


    }//Fin paintComponent
}//Fin Classe DessinerFrame
