   "schedule",
          scheduleXML,
          null,
          credentials,
          null,
          null,
          "en"
        );
 
        System.out.println("Created schedule...");
        
        // 5. Start the schedule
        
        // Create object key for schedule name
        ObjectKey objectKey = new ObjectKey();
        AdminKeyPair keyPair = new AdminKeyPair();
        keyPair.setKeyName( "name" ); // schedules identified by name
        keyPair.setKeyValue( "schedule1" ); // schedule name
        objectKey.getAdminKeyPairs().add( keyPair );
        
        adminPort.start(
          "schedule",
          objectKey,
          null,
          null,
          credentials,
          null,
          null,
          "en"
        );
        
        System.out.println("Started schedule..."); 
        System.out.println("Waiting 30 seconds to get status...");
        Thread.sleep( 30000 );
 
        // 6. Use object key above to get schedule state
        oo = adminPort.getState(
          "schedule",
          objectKey,
          null, // request all state properties
          credentials,
          null,
          "en"
        );
        
        System.out.println("Schedule state XML = " + oo.getObjectXML() );
      }
    }
    catch (AdminAPIRuntimeFault_Exception e)
    {
      AdminAPIRuntimeFault runtimeFault = e.getFaultInfo();
      System.out.println("Caught AdminAPIRuntimeFault");
      System.out.println("  message      = " + runtimeFault.getMessage() );
      System.out.println("  errorCode    = " + runtimeFault.getErrorCode() );
      System.out.println("  causeMessage = " + runtimeFault.getCauseMessage() );
      System.out.println("  stackTrace   = " );
      e.printStackTrace( System.out );
      System.out.println("  causeStackTrace = \n" + runtimeFault.getCauseStackTrace() );
    }
    catch (Throwable t)
    {
      System.out.println("Caught unexpected run-time exception");
      System.out.println("  message    = " + t.getMessage() );
      System.out.println("  stackTrace = " );
      t.printStackTrace( System.out );
    }
  }
 
  /**
   * Initializes and returns a stateless admin web service client.
   */
  private static AdminPortType getStatelessWebServiceClient(
    String webServiceURL) throws Exception
  {
    AdminService adminService = new AdminService(
      new URL( webServiceURL ),
      new QName(
        "http://search.oracle.com/Admin",
        "AdminService"
      )
    );
 
    return adminService.getAdmi
