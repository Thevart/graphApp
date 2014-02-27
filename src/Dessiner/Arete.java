package Dessiner;

import java.awt.Graphics;

public class Arete {

    public int xStart;
    public int yStart;
    public int xEnd;
    public int yEnd;
    public Sommet sommetSource;
    public Sommet sommetDest;
    public String formeArete;
    public String labelArete;
    public int IdArete;

    /* ce constructeur spécifie que le point de départ de l'arete est le milieu du sommet source
     * et le point d'arrivé est celui du sommet destination, chaque arete a un label qui indique
     * quel sommets sont reliés par cet arete. IDArete est un ID qui s'incrémente quand on crée
     * une nouvelle arete. 
     */
    public Arete(int x1, int y1, int x2, int y2, int ID, Sommet source, Sommet dest, String form, String label) {
        this.xStart = x1 + source.dx / 2;
        this.yStart = y1 + source.dy / 2;
        this.xEnd = x2 + dest.dx / 2;
        this.yEnd = y2 + dest.dy / 2;
        this.sommetSource = source;
        this.sommetDest = dest;
        this.formeArete = form;
        this.labelArete = label;
        this.IdArete = ID;
    }

    public void dessinerArete(Graphics g) {
        //switch (this.formeArete){
        //case "ligneDroite" :
        g.drawLine(this.xStart, this.yStart, this.xEnd, this.yEnd);
        // break;            
    }
}
