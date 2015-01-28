## Network

### UML

@startuml network.png

namespace nimpal {
    namespace network {

        class PAL_NetConnectionConfig {

            + PAL_NetConnectionStatusCallback   netStatusCallback
            + PAL_NetDataSentCallback           netDataSentCallback
            + PAL_NetDataReceivedCallback       netDataReceivedCallback
            + PAL_NetDnsResultCallback          netDnsResultCallback
            + PAL_NetHttpResponseStatusCallback netHttpResponseStatusCallback
            + PAL_NetHttpDataReceivedCallback   netHttpDataReceivedCallback
            + PAL_NetHttpResponseHeadersCallback  netHttpResponseHeadersCallback
            + void*                             userData
            + PAL_NetTLSConfig                  tlsConfig
        }

        class Callback {

            + void Invoke()

            # virtual void InvokeFunction()

            - void* m_function
            - void* m_userData
        }

        class CallbackDnsResult {

            + virtual void InvokeFunction()
        }

        class CallbackHttpData {

            + virtual void InvokeFunction()
        }

        class CallbackHttpResponseHeaders {

            + virtual void InvokeFunction()
        }

        class CallbackHttpResponseStatus {

            + virtual void InvokeFunction()
        }

        class CallbackNetworkData {

            + virtual void InvokeFunction()
        }

        class CallbackNetworkStatus {

            + virtual void InvokeFunction()
        }

        class CallbackManager {

            + PAL_Error Schedule(Callback* back)

        }

        class NetConnection {

            + virtual void Destroy() = 0
            + virtual PAL_Error Connect(const char* pHostName, uint16 port, struct sockaddr* localIpAddr = NULL) = 0
            + virtual PAL_Error Send(const byte* pBuffer, int count) = 0
            + virtual PAL_Error Close() = 0
            + virtual PAL_Error Send(const byte* pBuffer,
                                     uint32 count,
                                     const char* pVerb,
                                     const char* pObject,
                                     const char* pAcceptType,
                                     const char* pAdditionalHeaders,
                                     void* pRequestData) = 0
        }

        Callback <|-- CallbackDnsResult
        Callback <|-- CallbackHttpData
        Callback <|-- CallbackHttpResponseHeaders
        Callback <|-- CallbackHttpResponseStatus
        Callback <|-- CallbackNetworkData
        Callback <|-- CallbackNetworkStatus
        CallbackManager <|-- NetConnection
        CallbackManager "1" *-- "many" Callback
        NetConnection <|-- TCPConnectionAdapter
        NetConnection <|-- TLSConnectionAdapter
        NetConnection <|-- HttpConnection
        NetConnection <|-- HttpsConnectionAdapter
        NetConnection o-- Callback
        NetConnection -- PAL_NetConnectionConfig
        TCPConnectionAdapter *-- TCPConnection
        TLSConnectionAdapter *-- TLSConnection
        HttpsConnectionAdapter *-- HttpsConnection
    }
}

@enduml
