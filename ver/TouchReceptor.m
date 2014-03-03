//
//  TouchRecpetor.m
//  ver
//
//  Created by Arthur Thevenet on 27/02/14.
//
//

#import "TouchReceptor.h"
#import "DrawableVertex.h"
@implementation TouchReceptor
BOOL Dragging;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIColor *color = [ UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.backgroundColor = color;
        self.selectedVertices=[[NSMutableArray alloc]init];
        self.selectedEdges=[[NSMutableArray alloc]init];
    }
    return self;
}	

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    
    //init du bezier path
    self.currentPath = [UIBezierPath bezierPath];
    self.currentPath.lineWidth = 3.0;
    [self.currentPath moveToPoint:location];
    
    
    DrawableVertex *vertex = [self.graph vertexAtLocation:location];
    self.touchedVertex=vertex;
    if(self.touchedVertex !=nil){
        if (self.selectedVertices.count==1)
        {
            Dragging=NO;
        }
        else
        {
            Dragging=YES;
        }
    }
    self.firstPoint=location;
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
    if (Dragging == YES)
    {
        for (DrawableVertex* vertex in self.selectedVertices)
        {
            [vertex setPosition:location.x y:location.y];
            [self.graph setNeedsDisplay:vertex];
            NSLog(@"in the dragndrop");

        }
        [self.touchedVertex setPosition:location.x y:location.y];
        [self.graph setNeedsDisplay:self.touchedVertex];

    }
    else
    {
        //affichage patate ou edgeCreator
        [self.currentPath addLineToPoint:location];
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
            DrawableEdge* edge = [self.graph edgeAtLocation:location];
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
                    [self.graph addVertex:vertex];
                }
                //remove every edges of the list
            }
            [self recolorEdges];
            [self.selectedVertices removeAllObjects];
        }
    }
    else if(self.touchedVertex!=nil && Dragging == NO){
        DrawableVertex* vertex = [self.graph vertexAtLocation:location];
        //le trait fini sur un vertex, ajouter un edge
        if(vertex!=nil){
            DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:self.touchedVertex target:vertex];
            [edge setPosition: self.frame.size.width y:self.frame.size.height];
            [self.graph addEdge:edge];
        }
    }
    //selection patate
    else{
        self.selectedVertices = [self patateContainsPoint];
    }
    [self recolorVertices];
    [self.currentPath removeAllPoints];
    [self.graph setNeedsDisplay];
    [self setNeedsDisplay];
    Dragging=NO;
}
- (void)recolorVertices
{
    for(NSString *id in self.graph.vertices)
    {
        DrawableVertex *vertex=[self.graph.vertices objectForKey:id];
        if ([self.selectedVertices containsObject:vertex])
        {
            [vertex setColor:[Color initFromRGB:0 g:0 b:255]];
        }
        else{
            [vertex setColor:[Color initFromRGB:255 g:0 b:0]];
        }
    }
}

-(void) recolorEdges
{
    for(DrawableEdge* edge in self.graph.edges)
    {
        if([self.selectedEdges containsObject:edge])
        {
            edge.edgeView.color = [UIColor colorWithRed:255.0/255.0 green: 0.0/255.0 blue: 0.0/255.0 alpha: 1.0];
        }else{
            edge.edgeView.color = [UIColor colorWithRed:0.0/255.0 green: 0.0/255.0 blue: 255.0/255.0 alpha: 1.0];
        }
    }
}

- (void)drawRect:(CGRect)rect {		
    [[UIColor redColor] set];
    [self.currentPath stroke];
}

-(NSMutableArray*) patateContainsPoint
{
    //ajout des vertexs contenues dans la patate
    NSMutableArray *vertices = [[NSMutableArray alloc] init];
    for( NSString* id in self.graph.vertices)
    {
        DrawableVertex *vertex = [self.graph.vertices objectForKey:id];
        if([self.currentPath containsPoint:CGPointMake(vertex.coord.x, vertex.coord.y)])
        {
            [vertices addObject:vertex];
        }
    }
    return vertices;
}
-(void) delete
{
    if(self.selectedVertices.count>0){
        [self.selectedVertices removeAllObjects];
    }
    [self setNeedsDisplay];
}
@end
