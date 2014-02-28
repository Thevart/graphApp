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
    if (self) {
        UIColor *color = [ UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        self.backgroundColor = color;
        self.selectedVertices=[[NSMutableArray alloc]init];
    }
    return self;
}	

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    self.currentPath = [UIBezierPath bezierPath];
    self.currentPath.lineWidth = 3.0;
    [self.currentPath moveToPoint:[touch locationInView:self]];
    DrawableVertex *vertex = [self.graph vertexAtLocation:[touch locationInView:self]];
    if( [self.selectedVertices containsObject:vertex]){
        Dragging=YES;
    }else{
        self.touchedVertex=vertex;
    }
    
    self.firstPoint=[touch locationInView:self];
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
        newLoc.x=self.firstPoint.y-location.x;
    }else{
        newLoc.x=location.y+self.firstPoint.y;
    }
    return newLoc;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self];
    //dragNDrop
    if (Dragging == YES){
        for (DrawableVertex* vertex in self.selectedVertices)
        {
            [vertex setPosition:location.x y:location.y];
        }
        [self.graph setNeedsDisplay];
    } else{
        //affichage patate ou edgeCreator
        [self.currentPath addLineToPoint:location];
    }
   
    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location=[touch locationInView:self];
    for (DrawableVertex *vertex in self.selectedVertices)
    {
        [vertex setColor:[Color initFromRGB:255 g:0 b:0]];
    }
    self.selectedVertices = [self patateContainsPoint];
    //changement des couleurs
    for (DrawableVertex *vertex in self.selectedVertices)
    {
        [vertex setColor:[Color initFromRGB:0 g:0 b:255]];
    }
    //simple touch
    if(self.firstPoint.x == location.x && self.firstPoint.y==location.y){
        DrawableVertex* vertex=[self.graph vertexAtLocation:[touch locationInView:self]];
        if(vertex!=nil){
            //un vertex touché, ajouter le vertex selectionné a la liste des vertex
            [self.selectedVertices addObject:vertex];
            [self.graph switchSelectedVertex:vertex];
        }else{
            //ajouter un vertex, point touché, pas de dragging
            DrawableVertex* vertex = [[DrawableVertex alloc] initWithCoord:location.x y:location.y];
            [self.graph addVertex:vertex];
            [self.selectedVertices removeAllObjects];
        }
    }
    else if(self.touchedVertex!=nil){
        DrawableVertex* vertex = [self.graph vertexAtLocation:[touch locationInView:self]];
        //le trait fini sur un vertex, ajouter un edge
        if(vertex!=nil){
            DrawableEdge* edge = [[DrawableEdge alloc] initWithVertices:self.touchedVertex target:vertex];
            [edge setPosition: self.frame.size.width y:self.frame.size.height];
            [self.graph addEdge:edge];
        }
    }
    //effacer le trait de selection
    [self.currentPath removeAllPoints];
    [self setNeedsDisplay];
    Dragging=NO;
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
