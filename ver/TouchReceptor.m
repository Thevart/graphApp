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

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    
    //dragNDrop
    if (self.isDragging)
    {
        for (DrawableVertex* vertex in self.selectedVertices)
        {
            [vertex setPosition:location.x y:location.y];
            [graph setNeedsDisplay:vertex];
            NSLog(@"in the dragndrop");

        }
        [self.touchedVertex setPosition:location.x y:location.y];
        [graph setNeedsDisplay:self.touchedVertex];

    }
    else
    {
        //affichage patate ou edgeCreator
        [vertexSelector updateWithLocation:location];
    }
   
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location=[touch locationInView:self];

    //simple touch
    if(self.firstPoint.x == location.x && self.firstPoint.y==location.y){
        if (self.touchedVertex!=nil)
        {
            //un vertex touché, ajouter le vertex selectionné a la liste des vertex
            [self.selectedVertices addObject:self.touchedVertex];
            [self.selectedEdges removeAllObjects];
        }
        else
        {
            DrawableEdge* edge = [graph edgeAtLocation:location];
            //un edge a été touché
            if (edge != nil)
            {
                //edge déja dans la liste
                if ([self.selectedEdges containsObject:edge])
                {
                    edge.edgeView.color = [UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
                    [self.selectedEdges removeObject:edge];
                }
                //ajouter dans la liste
                else
                {
                    edge.edgeView.color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/0.0 alpha: 1.0];
                    [self.selectedEdges addObject:edge];
                }
            }
            //on a touché dans le vide
            else
            {
                //on déselectionne tout
                if (self.selectedVertices.count>0 || self.selectedEdges.count>0)
                {
                    [self.selectedVertices removeAllObjects];
                    [self.selectedEdges removeAllObjects];

                }
                //ajouter un vertex,vide touché, pas de dragging
                else
                {
                    DrawableVertex* vertex = [[DrawableVertex alloc] initWithCoord:location.x y:location.y];
                    [graph addVertex:vertex];
                }
                //remove every edges of the list
            }
            [self recolorEdges];
            [self.selectedVertices removeAllObjects];
        }
    } else if (self.touchedVertex!=nil && !self.isDragging) {
        DrawableVertex* vertex = [graph vertexAtLocation:location];
        //le trait fini sur un vertex, ajouter un edge
        if(vertex!=nil){
            DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:self.touchedVertex target:vertex];
            [edge setPosition: self.frame.size.width y:self.frame.size.height];
            [graph addEdge:edge];
        }
    }
    //selection patate
    else{
        self.selectedVertices = [NSMutableArray arrayWithArray:[vertexSelector getSelectedVertices]];
    }

    [self recolorVertices];
    [vertexSelector clear];
    [graph setNeedsDisplay];
    [self setNeedsDisplay];

    self.isDragging = NO;
}

- (void) recolorVertices
{
    for (NSString *id in graph.vertices) {
        DrawableVertex *vertex=[graph.vertices objectForKey:id];
        if ([self.selectedVertices containsObject:vertex]) {
            [vertex setColor:[Color initFromRGB:0 g:0 b:255]];
        } else {
            [vertex setColor:[Color initFromRGB:255 g:0 b:0]];
        }
    }
}

-(void) recolorEdges
{
    for (DrawableEdge* edge in graph.edges)
    {
        if([self.selectedEdges containsObject:edge]) {
            edge.edgeView.color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
        } else {
            edge.edgeView.color = [UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 255.0/255.0 alpha: 1.0];
        }
    }
}

- (void) drawRect:(CGRect)rect
{
    // update the vertex selection drawing
    [vertexSelector draw];
}

-(void) delete
{
    if(self.selectedVertices.count>0){
        [self.selectedVertices removeAllObjects];
    }
    [self setNeedsDisplay];
}

@end
