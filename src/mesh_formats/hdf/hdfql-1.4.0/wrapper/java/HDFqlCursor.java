/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.11
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */


public class HDFqlCursor {
  private transient long swigCPtr;
  protected transient boolean swigCMemOwn;

  protected HDFqlCursor(long cPtr, boolean cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = cPtr;
  }

  protected static long getCPtr(HDFqlCursor obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected void finalize() {
    delete();
  }

  public synchronized void delete() {
    if (swigCPtr != 0) {
      if (swigCMemOwn) {
        swigCMemOwn = false;
        HDFqlJNI.delete_HDFqlCursor(swigCPtr);
      }
      swigCPtr = 0;
    }
  }

  public HDFqlCursor() {
		this(HDFqlJNI.new_HDFqlCursor(), true);
		HDFqlJNI.cursorInitialize(swigCPtr, this);
	}

}
