//
//  MyDocument.m
//  FormulatePro
//
//  Created by Andrew de los Reyes on 7/4/06.
//  Copyright Andrew de los Reyes 2006 . All rights reserved.
//

#include <fcntl.h>
#include <unistd.h>

#import "MyDocument.h"
#import "FPArchivalDictionaryUpgrader.h"
#import "FPWindowController.h"
#import "FPGraphic.h"
#import "FPLogging.h"

//static NSString *nativeDocumentFormat = @"FormulatePro Document";

//static NSString* MyDocToolbarIdentifier =
//    @"info.adlr.formulatepro.documenttoolbaridentifier";
//static NSString *MyDocToolbarIdentifierZoomIn =
//    @"info.adlr.formulatepro.documenttoolbaridentifier.zoomin";
//static NSString *MyDocToolbarIdentifierZoomOut =
//    @"info.adlr.formulatepro.documenttoolbaridentifier.zoomout";
//static NSString *MyDocToolbarIdentifierOneUpTwoUpBook =
//    @"info.adlr.formulatepro.documenttoolbaridentifier.oneuptwoupBook";
//static NSString *MyDocToolbarIdentifierSingleContinuous =
//    @"info.adlr.formulatepro.documenttoolbaridentifier.singlecontinuous";
//static NSString *MyDocToolbarIdentifierNextPage =
//    @"info.adlr.formulatepro.documenttoolbaridentifier.nextpage";
//static NSString *MyDocToolbarIdentifierPreviousPage =
//    @"info.adlr.formulatepro.documenttoolbaridentifier.previouspage";

@interface MyDocument (Private)
- (void)setupToolbar;
@end

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
        _overlayGraphics = [[NSMutableArray array] retain];
    }
    return self;
}

- (void)dealloc
{
    [_originalPDFData release];
    [_pdf_document release];
    [_overlayGraphics release];
    [super dealloc];
}

- (PDFDocument *)pdfDocument
{
    return _pdf_document;
}

//- (NSString *)windowNibName
//{
//    // Override returning the nib file name of the document
//    // If you need to use a subclass of NSWindowController or if your document
//    // supports multiple NSWindowControllers, you should remove this method
//    // and override -makeWindowControllers instead.
//    return @"MyDocument";
//}

- (void)makeWindowControllers
{
    FPWindowController *wc = [[FPWindowController alloc] init];
    [self addWindowController:wc];
    [wc release];
}

//- (void)windowControllerDidLoadNib:(NSWindowController *) aController
//{
//    [super windowControllerDidLoadNib:aController];
//    // Add any code here that needs to be executed once the windowController
//    // has loaded the document's window.
//    
//    // Load PDF.
////    if ([self fileName])
////    {
////        // TODO(adlr): report nsdata error to the user
////        _originalPDFData = [NSData dataWithContentsOfURL:[self fileURL]
////                                                 options:0
////                                                   error:nil];
////        if (nil == _originalPDFData) {
////            // report error.
////            return;
////        }
////        [_originalPDFData retain];
////        _pdf_document = [[PDFDocument alloc] initWithData:_originalPDFData];
////        if (nil == _pdf_document) {
////            // report error.
////            return;
////        }
//    if (_pdf_document) {
//        [_document_view setPDFDocument:_pdf_document];
//        if (_tempOverlayGraphics) {
//            if ([FPArchivalDictionaryUpgrader currentVersion] > _tempOverlayGraphicsVersion) {
//                [FPArchivalDictionaryUpgrader upgradeGraphicsInPlace:_tempOverlayGraphics
//                                                         fromVersion:_tempOverlayGraphicsVersion];
//            }
//            [_document_view setOverlayGraphicsFromArray:_tempOverlayGraphics];
//            [_tempOverlayGraphics release];
//        }
//    } else {
//        assert(0);
//    }
//    
//    // toolbar item views
//    [_one_up_vs_two_up_vs_book retain];
//    [_one_up_vs_two_up_vs_book removeFromSuperview];
//
//    [_single_vs_continuous retain];
//    [_single_vs_continuous removeFromSuperview];
//    
////    switch ([_pdf_view displayMode]) {
////        case kPDFDisplaySinglePage:
////            [_pdf_view setDisplaysAsBook:NO];
////            [_one_up_vs_two_up_vs_book setSelectedSegment:0];
////            [_single_vs_continuous setSelectedSegment:0];
////            break;
////        case kPDFDisplaySinglePageContinuous:
////            [_pdf_view setDisplaysAsBook:NO];
////            [_one_up_vs_two_up_vs_book setSelectedSegment:0];
////            [_single_vs_continuous setSelectedSegment:1];
////            break;
////        case kPDFDisplayTwoUp:
////            if ([_pdf_view displaysAsBook]) {
////                [_one_up_vs_two_up_vs_book setSelectedSegment:2];
////                [_single_vs_continuous setSelectedSegment:0];
////            } else {
////                [_one_up_vs_two_up_vs_book setSelectedSegment:1];
////                [_single_vs_continuous setSelectedSegment:0];
////            }
////            break;
////        case kPDFDisplayTwoUpContinuous:
////            if ([_pdf_view displaysAsBook]) {
////                [_one_up_vs_two_up_vs_book setSelectedSegment:2];
////                [_single_vs_continuous setSelectedSegment:1];
////            } else {
////                [_one_up_vs_two_up_vs_book setSelectedSegment:1];
////                [_single_vs_continuous setSelectedSegment:1];
////            }
////            break;
////    }
//    
//    [self setupToolbar];
//}

//+ (NSArray *)readableTypes
//{
//    return [NSArray arrayWithObjects:nativeDocumentFormat,
//                                     @"PDF Document",
//                                     nil];
//}
//
//+ (NSArray *)writableTypes
//{
//    return [NSArray arrayWithObject:nativeDocumentFormat];
//}
//
//+ (BOOL)isNativeType:(NSString *)aType
//{
//    return [aType isEqualToString:nativeDocumentFormat];
//}

//- (NSData *)dataRepresentationOfType:(NSString *)aType
//{
    // Insert code here to write your document from the given data.  You can
    // also choose to override -fileWrapperRepresentationOfType: or
    // -writeToFile:ofType: instead.
    
    // For applications targeted for Tiger or later systems, you should use
    // the new Tiger API -dataOfType:error:.  In this case you can also choose
    // to override -writeToURL:ofType:error:, -fileWrapperOfType:error:, or
    // -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

//    return nil;
//}

- (NSArray *)archivalOverlayGraphics
{
    NSMutableArray *arr = [NSMutableArray array];
    for (unsigned int i = 0; i < [_overlayGraphics count]; i++) {
        [arr
         addObject:[[_overlayGraphics objectAtIndex:i] archivalDictionary]];
    }
    return arr;
}

- (void)setOverlayGraphicsFromArray:(NSArray *)arr
{
    [_overlayGraphics removeAllObjects];
    for (unsigned int i = 0; i < [arr count]; i++) {
        [_overlayGraphics addObject:
            [FPGraphic graphicFromArchivalDictionary:[arr objectAtIndex:i]]];
    }
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    NSLog(@"dataOfType:%@\n", typeName);
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    NSLog(@"line %d\n", __LINE__);
    [d setObject:_originalPDFData forKey:@"originalPDFData"];
    NSLog(@"line %d\n", __LINE__);
    [d setObject:[self archivalOverlayGraphics]
          forKey:@"archivalOverlayGraphics"];
    NSLog(@"line %d\n", __LINE__);
    [d setObject:[NSNumber numberWithInt:[FPArchivalDictionaryUpgrader currentVersion]]
          forKey:@"version"];
    NSLog(@"line %d\n", __LINE__);
    

    NSString *errorDesc;
    NSData *ret =
        [NSPropertyListSerialization
         dataFromPropertyList:d
                       format:NSPropertyListXMLFormat_v1_0
             errorDescription:&errorDesc];
    if (nil == ret) {
        NSLog(@"error: %@\n", errorDesc);
        [errorDesc release];
        return [NSData data];
    }
    return ret;
}

- (BOOL)readFromData:(NSData *)data
              ofType:(NSString *)typeName
               error:(NSError **)outError
{
    NSLog(@"readFromData:0x%08x ofType:%@\n", (unsigned)data, typeName);
    if ([typeName isEqualToString:@"PDF Document"]) {
        _originalPDFData = [data retain];
        [self setFileURL:nil];  // causes document to be "untitled" and otherwise
                                // act like a brand new document. e.g. file->save
                                // pops the save-as dialog
    } else if ([typeName isEqualToString:@"FormulatePro Document"]) {
        NSMutableDictionary *dict =
            [NSPropertyListSerialization
             propertyListFromData:data
                 mutabilityOption:NSPropertyListMutableContainersAndLeaves
                           format:nil
                 errorDescription:nil];
        assert(nil != dict);
        // TODO(adlr): check for error, version, convert these keys to
        // constants
        _originalPDFData = [[dict objectForKey:@"originalPDFData"] retain];
        NSMutableArray *overlayGraphicsArr = [[dict objectForKey:@"archivalOverlayGraphics"]
                              retain];
        int tempOverlayGraphicsVersion = [[dict objectForKey:@"version"] intValue];
        if ([FPArchivalDictionaryUpgrader currentVersion] < tempOverlayGraphicsVersion) {
            *outError = [NSError errorWithDomain:@"info.adlr.FormulatePro.ErrorDomain"
                                            code:1
                                        userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                            @"Bad Version.",NSLocalizedDescriptionKey,
                                            @"The file was created with a newer version of "
                                            @"FormulatePro.",NSLocalizedFailureReasonErrorKey,
                                            nil]];
            return NO;
        }
        if ([FPArchivalDictionaryUpgrader currentVersion] > tempOverlayGraphicsVersion) {
            [FPArchivalDictionaryUpgrader upgradeGraphicsInPlace:overlayGraphicsArr
                                                     fromVersion:tempOverlayGraphicsVersion];
        }
        [self setOverlayGraphicsFromArray:overlayGraphicsArr];
    }

    _pdf_document = [[PDFDocument alloc] initWithData:_originalPDFData];
    if (nil == _pdf_document) {
        // report error
        NSLog(@"error with PDF format!\n");
        return NO;
    }
    return YES;
}

- (NSMutableArray *)overlayGraphics
{
    assert(_overlayGraphics);
    return _overlayGraphics;
}

//- (void)setOverlayGraphics:(NSMutableArray *)overlayGraphics
//{
//    DLog(@"setOverlayGraphics:0x%08x called\n", (unsigned int)overlayGraphics);
//    DLog(@"original: 0x%08x\n", _overlayGraphics);
//    if (overlayGraphics == _overlayGraphics)
//        return;
//    [_overlayGraphics autorelease];
//    _overlayGraphics = [overlayGraphics retain];
//}

//- (IBAction)zoomIn:(id)sender
//{
//    [_document_view zoomIn:sender];
//}
//
//- (IBAction)zoomOut:(id)sender
//{
//    [_document_view zoomOut:sender];
//}

//- (IBAction)toggleContinuous:(id)sender
//{
////    PDFDisplayMode new_mode = kPDFDisplaySinglePage;
////    
////    if (sender == _single_vs_continuous) {
////        int ss = [_single_vs_continuous selectedSegment];
////        switch([_pdf_view displayMode]) {
////            case kPDFDisplaySinglePage: // fall through
////            case kPDFDisplaySinglePageContinuous:
////                new_mode =
////                    (ss==1?kPDFDisplaySinglePageContinuous:
////                           kPDFDisplaySinglePage); break;
////            case kPDFDisplayTwoUp: // fall through
////            case kPDFDisplayTwoUpContinuous:
////                new_mode = (ss==1?kPDFDisplayTwoUpContinuous:
////                                  kPDFDisplayTwoUp); break;
////        }
////    } else {
////        switch([_pdf_view displayMode]) {
////            case kPDFDisplaySinglePage:
////                new_mode = kPDFDisplaySinglePageContinuous; break;
////            case kPDFDisplaySinglePageContinuous:
////                new_mode = kPDFDisplaySinglePage; break;
////            case kPDFDisplayTwoUp:
////                new_mode = kPDFDisplayTwoUpContinuous; break;
////            case kPDFDisplayTwoUpContinuous:
////                new_mode = kPDFDisplayTwoUp; break;
////        }
////    }
////    [_pdf_view setDisplayMode:new_mode];    
//}
//
//- (IBAction)toggleOneUpTwoUpBookMode:(id)sender
//{
////    PDFDisplayMode new_up_mode = kPDFDisplaySinglePage;
////    BOOL book_mode = NO;
////    int sc_idx = 0;
////    
////    if (sender == _one_up_vs_two_up_vs_book) {
////        int cont =
////            [_pdf_view displayMode] == kPDFDisplaySinglePageContinuous ||
////            [_pdf_view displayMode] == kPDFDisplayTwoUpContinuous;
////        if ([_one_up_vs_two_up_vs_book selectedSegment] == 0) {
////            if (cont)
////                new_up_mode = kPDFDisplaySinglePageContinuous;
////            else
////                new_up_mode = kPDFDisplaySinglePage;
////        } else {
////            if (cont)
////                new_up_mode = kPDFDisplayTwoUpContinuous;
////            else
////                new_up_mode = kPDFDisplayTwoUp;
////        }
////        [_pdf_view setDisplaysAsBook:
////         ([_one_up_vs_two_up_vs_book selectedSegment] == 2)];
////        [_pdf_view setDisplayMode:new_up_mode];
////        return;
////    }
////    
////    switch([_pdf_view displayMode]) {
////        case kPDFDisplaySinglePage:
////            new_up_mode = kPDFDisplayTwoUp;
////            book_mode = NO;
////            sc_idx = 1;
////            break;
////        case kPDFDisplaySinglePageContinuous:
////            new_up_mode = kPDFDisplayTwoUpContinuous;
////            book_mode = NO;
////            sc_idx = 1;
////            break;
////        case kPDFDisplayTwoUp:
////            if ([_pdf_view displaysAsBook] == NO) {
////                new_up_mode = [_pdf_view displayMode];
////                book_mode = YES;
////                sc_idx = 2;
////            } else {
////                new_up_mode = kPDFDisplaySinglePage;
////                book_mode = NO;
////                sc_idx = 3;
////            }
////            break;
////        case kPDFDisplayTwoUpContinuous:
////            if ([_pdf_view displaysAsBook] == NO) {
////                new_up_mode = [_pdf_view displayMode];
////                book_mode = YES;
////                sc_idx = 2;
////            } else {
////                new_up_mode = kPDFDisplaySinglePageContinuous;
////                book_mode = NO;
////                sc_idx = 3;
////            }
////            break;
////            
////    }
////    [_pdf_view setDisplayMode:new_up_mode];
////    if ([_pdf_view displaysAsBook] != book_mode)
////        [_pdf_view setDisplaysAsBook:book_mode];
////    [_one_up_vs_two_up_vs_book setSelectedSegment:sc_idx];
//}

//#pragma mark -
//#pragma mark Printing Methods
//
//// This method will only be invoked on Mac 10.4 and later. If you're writing
//// an application that has to run on 10.3.x and earlier you should override
//// -printShowingPrintPanel: instead.
//- (NSPrintOperation *)printOperationWithSettings:(NSDictionary *)printSettings
//                                           error:(NSError **)outError {
//    NSLog(@"print operations\n");
//    // Create a view that will be used just for printing.
//    //NSSize documentSize = [self documentSize];
//    //SKTRenderingView *renderingView = [[SKTRenderingView alloc]
//    //    initWithFrame:NSMakeRect(0.0, 0.0, documentSize.width,
//    //                             documentSize.height)
//    //         graphics:[self graphics]];
//    FPDocumentView *printView = [_document_view printableCopy];
//    
//    // Create a print operation.
//    NSPrintOperation *printOperation =
//        [NSPrintOperation printOperationWithView:printView
//                                       printInfo:[self printInfo]];
//    [printView release];
//    
//    // Specify that the print operation can run in a separate thread. This
//    // will cause the print progress panel to appear as a sheet on the
//    // document window.
//    [printOperation setCanSpawnSeparateThread:YES];
//    
//    // Set any print settings that might have been specified in a Print
//    // Document Apple event. We do it this way because we shouldn't be
//    // mutating the result of [self printInfo] here, and using the result of
//    // [printOperation printInfo], a copy of the original print info, means we
//    // don't have to make yet another temporary copy of [self printInfo].
//    [[[printOperation printInfo] dictionary]
//        addEntriesFromDictionary:printSettings];
//    //[[[printOperation printInfo] dictionary]
//    //    setValue:[NSNumber numberWithInt:[_pdf_document pageCount]]
//    //      forKey:@"NSPagesAcross"];
//    [[[printOperation printInfo] dictionary]
//        setValue:[NSNumber numberWithInt:[_pdf_document pageCount]]
//          forKey:@"NSLastPage"];
//    
//    // add option for (not) printing original PDF
//    // this uses deprecated method b/c the replacement method is 10.5 only
//    [printOperation setAccessoryView:_print_accessory_view];
//    
//    // We don't have to autorelease the print operation because
//    // +[NSPrintOperation printOperationWithView:printInfo:] of course already
//    // autoreleased it. Nothing in this method can fail, so we never return
//    // nil, so we don't have to worry about setting *outError.
//    return printOperation;
//}
//
//- (void)setPrintInfo:(NSPrintInfo *)printInfo
//{
//    NSLog(@"setPrintInfo\n");
//    NSLog(@"print info dict: %@\n", [printInfo dictionary]);
//    [super setPrintInfo:printInfo];
//}
//
//- (BOOL)drawsOriginalPDF
//{
//    return [_print_original_pdf boolValue];
//}

@end
