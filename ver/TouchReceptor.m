//
//  TouchRecpetor.m
//  ver
//
//  Created by Arthur Thevenet on 27/02/14.
//
//

#import "TouchReceptor.h"
#import "DrawableVertex.h"
#import "FingerVertexSelector.h"

@interface TouchReceptor ()

@property (readwrite) BOOL isDragging;

@end

@implementation TouchReceptor

FingerVertexSelector *vertexSelector;
DrawableGraph* graph;

- (id) initWithFrameAndGraph:(CGRect)frame graph:(DrawableGraph*) g
{
    if (self = [super initWithFrame:frame]) {
        UIColor *color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.backgroundColor = color;
        self.selectedVertices = [[NSMutableArray alloc] init];
        self.selectedEdges = [[NSMutableArray alloc] init];

        vertexSelector = [[FingerVertexSelector alloc] initWithGraph:graph];
        graph = g;
    }

    return self;
}	

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    
    // init de la patate de sélection de vertex
    [vertexSelector clear];
    [vertexSelector startSelectionAtLocation:location];
    
    DrawableVertex *vertex = [graph vertexAtLocation:location];
    
    self.touchedVertex = vertex;
    if (vertex) {
        self.isDragging = self.selectedVertices.count != 1;
    }

    self.firstPoint = location;
}

-(CGPoint) translatePoint:(CGPoint)location
{
    CGPoint newLoc = CGPointZero;
    if(self.firstPoint.x>location.x){
        newLoc.x=self.firstPoint.x-location.x;
    }else{
        newLoc.x=location.x-self.firstPoint.x;
    }
    if(self.firstPoint.y>location.y){
        newLoc.y=self.firstPoint.y-location.y;
    }else{
        newLoc.y=location.y-self.firstPoint.y;
    }
    return newLoc;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *) event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    
    // dragNDrop
    if (self.isDragging) {
        for (DrawableVertex* vertex in self.selectedVertices) {
            [vertex setPosition:location.x y:location.y];

            NSLog(@"in the dragndrop");
        }

        [self.touchedVertex setPosition:location.x y:location.y];
    } else {
        //affichage patate ou edgeCreator
        [vertexSelector updateWithLocation:location];
    }
   
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];

    //simple touch
    if (self.firstPoint.x == location.x && self.firstPoint.y==location.y) {
        // vertex clicked
        if (self.touchedVertex != nil) {
            [self onUnselectEdges];
            [self onVertexClicked:self.touchedVertex];
        } else {
            DrawableEdge* edge = [graph edgeAtLocation:location];

            // un edge a été touché
            if (edge != nil) {
                [self onUnselectVertices];
                [self onEdgeClicked:edge];
            }
            //on a touché dans le vide
            else
            {
                // on déselectionne tout
                if (self.selectedVertices.count > 0) {
                    [self onUnselectVertices];
                } else if (self.selectedEdges.count > 0) {
                    [self onUnselectEdges];
                } else {
                    // ajouter un vertex, vide touché, pas de dragging
                    [self onVertexCreated:location];
                }
            }
        }
    } else if (self.touchedVertex != nil && !self.isDragging) {
        DrawableVertex* vertex = [graph vertexAtLocation:location];

        // le trait fini sur un vertex, ajouter un edge
        if (vertex != nil) {
            [self onEdgeCreated:self.touchedVertex target:vertex];
        }
    }
    //selection patate
    else {
        [self onSelectVertices:[vertexSelector getSelectedVertices]];
    }

    [vertexSelector clear];

    self.isDragging = NO;
}


- (void) drawRect:(CGRect)rect
{
    // update the vertex selection drawing
    [vertexSelector draw];
}

-(void) delete
{
    if (self.selectedVertices.count>0){
        [self.selectedVertices removeAllObjects];
    }

    [self setNeedsDisplay];
}

-(void) onVertexClicked: (Vertex*) vertex
{
    Color *color;

    // toggle de l'état du vertex : (dé)sélectionné
    if ([self.selectedVertices containsObject:vertex]) {
        color = [Color initFromRGB:0 g:0 b:255];
        [self.selectedVertices removeObject:vertex];
    } else {
        color = [Color initFromRGB:255 g:0 b:0];
        [self.selectedVertices addObject:vertex];
    }

    [vertex setColor:color];
}

-(void) onEdgeClicked: (DrawableEdge*) edge
{
    UIColor *color;

    // toggle de l'état de l'edge : (dé)sélectionné
    if ([self.selectedEdges containsObject:edge]) {
        color = [UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 255.0/255.0 alpha: 1.0];
        [self.selectedEdges removeObject:edge];
    } else {
        color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/0.0 alpha: 1.0];
        [self.selectedEdges addObject:edge];
    }

    edge.edgeView.color = color;
    [edge.edgeView setNeedsDisplay];
}

-(void) onEdgeCreated: (Vertex*) origin target:(Vertex*) target
{
    DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:origin target:target];
    [edge setPosition:self.frame.size.width y:self.frame.size.height];

    [graph addEdge:edge];
}

-(void) onVertexCreated: (CGPoint) location
{
    DrawableVertex* vertex = [[DrawableVertex alloc] initWithCoord:location.x y:location.y];
    [graph addVertex:vertex];
}

-(void) onUnselectEdges
{
    for (DrawableEdge* edge in self.selectedEdges) {
        edge.edgeView.color = [UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
        [edge.edgeView setNeedsDisplay];
    }

    [self.selectedEdges removeAllObjects];
}

-(void) onUnselectVertices
{
    for (DrawableVertex* vertex in self.selectedVertices) {
        [vertex setColor:[Color initFromRGB:0 g:0 b:255]];
    }

    [self.selectedVertices removeAllObjects];
}

-(void) onSelectVertices: (NSArray*) vertices
{
    // suppression de la précédente sélection
    [self onUnselectVertices];

    // création de la nouvelle
    self.selectedVertices = [NSMutableArray arrayWithArray:vertices];

    // et mise à jour des couleurs
    for (DrawableVertex* vertex in self.selectedVertices) {
        [vertex setColor:[Color initFromRGB:255 g:0 b:0]];
    }
}

@end
